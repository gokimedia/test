#!/bin/bash
# Nextcloud Bug Bounty - Eligible Repositories

repos=(
    # Core
    "nextcloud/server"
    "nextcloud/3rdparty"
    
    # Authentication & Security
    "nextcloud/user_saml"
    "nextcloud/user_oidc"
    "nextcloud/password_policy"
    "nextcloud/twofactor_totp"
    "nextcloud/twofactor_webauthn"
    "nextcloud/bruteforcesettings"
    "nextcloud/suspicious_login"
    "nextcloud/end_to_end_encryption"
    
    # Communication
    "nextcloud/spreed"
    "nextcloud/mail"
    "nextcloud/notifications"
    "nextcloud/nextcloud_announcements"
    "nextcloud/notify_push"
    
    # Files & Storage
    "nextcloud/files_accesscontrol"
    "nextcloud/files_antivirus"
    "nextcloud/files_automatedtagging"
    "nextcloud/files_confidential"
    "nextcloud/files_fulltextsearch"
    "nextcloud/files_lock"
    "nextcloud/files_pdfviewer"
    "nextcloud/files_retention"
    "nextcloud/files_rightclick"
    "nextcloud/files_texteditor"
    "nextcloud/groupfolders"
    
    # Apps
    "nextcloud/activity"
    "nextcloud/approval"
    "nextcloud/calendar"
    "nextcloud/calendar_resource_management"
    "nextcloud/circles"
    "nextcloud/collectives"
    "nextcloud/contacts"
    "nextcloud/data_request"
    "nextcloud/deck"
    "nextcloud/external"
    "nextcloud/firstrunwizard"
    "nextcloud/flow_notifications"
    "nextcloud/fulltextsearch"
    "nextcloud/fulltextsearch_elasticsearch"
    "nextcloud/globalsiteselector"
    "nextcloud/guests"
    "nextcloud/logreader"
    "nextcloud/notes"
    "nextcloud/photos"
    "nextcloud/privacy"
    "nextcloud/recommendations"
    "nextcloud/related_resources"
    "nextcloud/richdocuments"
    "nextcloud/serverinfo"
    "nextcloud/sharepoint"
    "nextcloud/socialsharing"
    "nextcloud/survey_client"
    "nextcloud/tables"
    "nextcloud/terms_of_service"
    "nextcloud/text"
    "nextcloud/updater"
    "nextcloud/user_migration"
    "nextcloud/viewer"
    "nextcloud/workflow_script"
    
    # Third-party integrations
    "ONLYOFFICE/onlyoffice-nextcloud"
    "daita/files_fulltextsearch_tesseract"
    
    # Update infrastructure (for integrity research)
    "nextcloud/updater_server"
    "nextcloud/client_updater_server"
    
    # App store
    "nextcloud/appstore"
    
    # Survey & Announcements
    "nextcloud/survey_server"
    "nextcloud/announcer"
    
    # Lookup server
    "nextcloud/lookup-server"
)

echo "Total repos to clone: ${#repos[@]}"
echo "================================"

for repo in "${repos[@]}"; do
    dir_name=$(basename "$repo")
    if [ -d "$dir_name" ]; then
        echo "[SKIP] $repo already exists"
    else
        echo "[CLONE] $repo"
        git clone --depth 1 "https://github.com/$repo.git" "$dir_name" 2>/dev/null &
    fi
    
    # Limit parallel jobs to 10
    while [ $(jobs -r | wc -l) -ge 10 ]; do
        sleep 1
    done
done

wait
echo "================================"
echo "Done! Cloning complete."
