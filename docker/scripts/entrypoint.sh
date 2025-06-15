#!/bin/bash

set -e  # Exit on error

# Load utility functions
. /docker/util_functions.sh

# Environment variables with default values
VENV_PATH="${VENV_PATH:-/venv}"
APP_PATH="${APP_PATH:-/app}"
REPO_DEPTH="${REPO_DEPTH:-1}"
USE_VENV="${USE_VENV:-true}"
REPO_URL="${REPO_URL:-https://github.com/hikariatama/Hikka}"
REPO_BRANCH="${REPO_BRANCH:-master}"

log_info "Using configuration:"
log_info "  VENV_PATH: $VENV_PATH"
log_info "  APP_PATH: $APP_PATH"
log_info "  USE_VENV: $USE_VENV"
log_info "  REPO_URL: $REPO_URL"
log_info "  REPO_BRANCH: $REPO_BRANCH"
log_info "  REPO_DEPTH: $REPO_DEPTH"

# Check if REPO_URL is set when needed
if [ ! -e "$APP_PATH/.git" ] && [ -z "$REPO_URL" ]; then
    log_error "REPO_URL must be set when repository doesn't exist"
    exit 1
fi

# Handle virtual environment
if is_true "$USE_VENV"; then
    log_info "Using virtual environment"
    
    # Check if recreate is needed
    need_recreate=false
    
    if ! venv_exists "$VENV_PATH"; then
        log_info "Virtual environment does not exist"
        need_recreate=true
    elif [ ! -e "$VENV_PATH/version" ]; then
        log_info "Version file not found"
        need_recreate=true
    elif [ "$(python_version)" != "$(cat $VENV_PATH/version)" ]; then
        log_warn "Python version changed from $(cat $VENV_PATH/version) to $(python_version)"
        need_recreate=true
    else
        log_info "Virtual environment is up to date"
    fi

    if [ "$need_recreate" = true ]; then
        remove_venv "$VENV_PATH"
        create_venv "$VENV_PATH" || exit 1
    fi
    
    # Activate virtual environment
    activate_venv "$VENV_PATH" || exit 1
else
    log_info "Virtual environment disabled"
fi

# Clone repository if needed
if [ -n "$REPO_URL" ]; then
    if ! clone_repository "$REPO_URL" "$REPO_BRANCH" "$APP_PATH" "$REPO_DEPTH"; then
        exit 1
    fi
fi

# Change to application directory
cd "$APP_PATH"

# Install dependencies if requirements.txt exists
if file_exists_and_not_empty "requirements.txt"; then
    log_info "Installing dependencies from requirements.txt"
    if ! pip install -r requirements.txt; then
        log_error "Failed to install dependencies"
        exit 1
    fi
fi

# Start the application
log_info "Starting Hikka application"
exec python3 -m hikka
