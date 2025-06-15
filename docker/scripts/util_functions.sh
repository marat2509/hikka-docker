#!/bin/bash

# Simple logging without colors
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warn() {
    echo "[WARN] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo "[SUCCESS] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Check boolean values with flexible input
is_true() {
    local value=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case "$value" in
        true|yes|1|on|enabled) return 0 ;;
        *) return 1 ;;
    esac
}

# Get Python version
python_version() {
    python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))"
}

# Deactivate virtual environment if active
deactivate_venv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        log_info "Deactivating virtual environment: $VIRTUAL_ENV"
        deactivate 2>/dev/null || true
    fi
}

# Remove virtual environment contents safely
remove_venv() {
    local venv_path="$1"
    
    if [ -z "$venv_path" ] || [ "$venv_path" = "/" ]; then
        log_error "Unsafe path for venv removal: $venv_path"
        return 1
    fi
    
    if [ -d "$venv_path" ]; then
        log_warn "Cleaning virtual environment contents: $venv_path"
        
        # Deactivate if this venv is currently active
        if [ "$VIRTUAL_ENV" = "$venv_path" ]; then
            deactivate_venv
        fi
        
        # Remove contents but keep the directory structure
        rm -rf "$venv_path"/*
        rm -rf "$venv_path"/.*[!.]* 2>/dev/null || true  # Remove hidden files except . and ..
        
        # Check if contents were removed successfully
        if [ -z "$(ls -A "$venv_path" 2>/dev/null)" ]; then
            log_success "Virtual environment contents removed successfully"
        else
            log_error "Failed to remove some virtual environment contents"
            return 1
        fi
    else
        log_info "Virtual environment does not exist: $venv_path"
    fi
}
# Create virtual environment
create_venv() {
    local venv_path="$1"
    
    log_info "Creating virtual environment at $venv_path"
    
    if ! python3 -m venv "$venv_path"; then
        log_error "Failed to create virtual environment"
        return 1
    fi
    
    echo $(python_version) > "$venv_path/version"
    log_success "Virtual environment created successfully"
}

# Activate virtual environment
activate_venv() {
    local venv_path="$1"
    
    if [ -f "$venv_path/bin/activate" ]; then
        source "$venv_path/bin/activate"
        log_info "Virtual environment activated: $venv_path"
        return 0
    else
        log_error "Activation file not found: $venv_path/bin/activate"
        return 1
    fi
}

# Check if virtual environment exists and is valid
venv_exists() {
    local venv_path="$1"
    [ -d "$venv_path" ] && [ -f "$venv_path/bin/activate" ] && [ -f "$venv_path/pyvenv.cfg" ]
}

# Check if virtual environment is currently active
venv_is_active() {
    [ -n "$VIRTUAL_ENV" ]
}

# Get currently active virtual environment path
get_active_venv() {
    echo "$VIRTUAL_ENV"
}

# Clone repository
clone_repository() {
    local repo_url="$1"
    local branch="$2"
    local target_dir="$3"
    local depth="${4:-1}"
    
    if [ -z "$repo_url" ] || [ -z "$target_dir" ]; then
        log_error "Required parameters: repo_url and target_dir"
        return 1
    fi
    
    # Check if repository already exists
    if [ -e "$target_dir/.git" ]; then
        log_info "Repository already exists at $target_dir"
        return 0
    fi
    
    log_info "Cloning repository $repo_url to $target_dir"
    
    local git_cmd="git clone \"$repo_url\""
    
    if [ -n "$branch" ]; then
        git_cmd="$git_cmd -b \"$branch\""
    fi
    
    git_cmd="$git_cmd --depth=$depth \"$target_dir\""
    
    if eval $git_cmd; then
        log_success "Repository cloned successfully"
        return 0
    else
        log_error "Failed to clone repository"
        return 1
    fi
}

# Check if file exists and is not empty
file_exists_and_not_empty() {
    [ -s "$1" ]
}

# Check if directory exists
dir_exists() {
    [ -d "$1" ]
}
