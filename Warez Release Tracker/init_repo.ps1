# Run this once after extracting the zip to set up the git repository.
# This creates the git history that scanning tools will analyse.

git init
git config user.email "sysop@warez.local"
git config user.name "Sysop"

# Initial commit with a database backup credential.
# The URL is assembled from parts so the credential lives only in the file this
# script writes (backup.py), not in the script itself. Secret scanners should
# find it in the deleted file in history, not here.
$user = "warez_backup"
$pass = "topcrack_db_4dm1n"
$dbhost = "backup.warez.local:5432"
"DB_BACKUP_URL = 'postgresql://${user}:${pass}@${dbhost}/warezdb'" | Out-File -FilePath backup.py -Encoding utf8
git add backup.py
git commit -m "add database backup config"

# Remove the credential file
git rm backup.py
git commit -m "remove old backup script"

# Commit the application files
git add .
git commit -m "warez tracker v1.0"

Write-Host "Repository initialised. Run 'docker compose up' to start the app."
