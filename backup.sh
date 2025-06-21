#!/bin/bash

# === CONFIGURABLE VARIABLES ===
BACKUP_DIR="$HOME/backups"            # Default backup destination
LOG_FILE="$BACKUP_DIR/backup.log"     # Log file
MAX_BACKUPS=5                         # How many backups to keep
COMPRESS=true                         # Set to 'false' to disable compression

# === FUNCTION: log messages ===
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# === CHECK: Input validation ===
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/source_folder"
    exit 1
fi

SOURCE_DIR="$1"

if [ ! -d "$SOURCE_DIR" ]; then
    log "ERROR: Source directory '$SOURCE_DIR' does not exist."
    exit 2
fi

if [ ! -r "$SOURCE_DIR" ]; then
    log "ERROR: No read permission for '$SOURCE_DIR'."
    exit 3
fi

# === Create backup directory if not exists ===
mkdir -p "$BACKUP_DIR"

# === Generate backup filename ===
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FOLDER_NAME=$(basename "$SOURCE_DIR")
BACKUP_NAME="${FOLDER_NAME}_backup_$TIMESTAMP"

# === Create the backup ===
if [ "$COMPRESS" = true ]; then
    BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME.tar.gz"
    tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$FOLDER_NAME"
else
    BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"
    cp -r "$SOURCE_DIR" "$BACKUP_PATH"
fi

# === Check if backup succeeded ===
if [ $? -eq 0 ]; then
    log "Backup created successfully: $BACKUP_PATH"
else
    log "ERROR: Backup failed."
    exit 4
fi

# === Retention policy: Keep only the latest N backups ===
BACKUP_FILES=($(ls -tp "$BACKUP_DIR" | grep "${FOLDER_NAME}_backup_" | grep -v '/'))

if [ ${#BACKUP_FILES[@]} -gt $MAX_BACKUPS ]; then
    DELETE_COUNT=$((${#BACKUP_FILES[@]} - MAX_BACKUPS))
    for ((i=${MAX_BACKUPS}; i<${#BACKUP_FILES[@]}; i++)); do
        rm -f "$BACKUP_DIR/${BACKUP_FILES[$i]}"
        log "Old backup deleted: ${BACKUP_FILES[$i]}"
    done
fi

exit 0

