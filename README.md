# 🗄️ Backup Script (`backup.sh`)

A simple, automated Bash script for backing up directories with optional compression, version history, and retention policy. Designed for Linux systems (Ubuntu-compatible), ideal for automating regular file backups via `cron`.

---

## 💡 Git Workflow & Features

- **`git add`**  
  Used to stage each version of the backup script as new features were added.

- **`git commit`**  
  Saved snapshots of the script with clear messages describing updates (e.g., added logging, implemented compression).

- **`git push`**  
  Pushed local commits to the remote repository for version control and backup.

- **`git branch`**  
  Created and managed separate branches to develop features like compression and backup retention without affecting the main branch.

---

## 📦 Script Features

- **✅ Input Validation**  
  Ensures the source directory exists and is readable before proceeding.

- **📝 Logging System**  
  Logs all operations and errors with timestamps to a log file (`backup.log`).

- **📂 Backup Creation**  
  Backs up the specified folder with a timestamped name for easy tracking.

- **🗜️ Optional Compression**  
  Compresses backups into `.tar.gz` format when `COMPRESS=true` (configurable).

- **📁 Auto-Create Backup Directory**  
  Automatically creates the destination backup directory if it doesn't exist.

- **♻️ Retention Policy**  
  Automatically keeps only the latest `N` backups (controlled by `MAX_BACKUPS`) and deletes older ones.

---


---

## 📦 Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/roniman100/backup-task.git
   cd backup-script
2. **Usage**:
   ```bash
   ./backup.sh /path/to/source_folder
# backup-task
