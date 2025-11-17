# GitHub Environments Demo

This repository demonstrates GitHub Environments and Protection Rules with GitHub Pages deployment.

## Setup Instructions

### 1. Enable GitHub Pages
1. Go to **Settings** → **Pages**
2. Under **Source**, select **GitHub Actions**

### 2. Create Environments

Create three environments with their respective variables and secrets:

#### Production Environment (`prod`)
- **Name**: `prod`
- **Protection Rules**: 
  - Required reviewers (recommended)
  - Deployment branch: `main` only
- **Environment Variables**:
  - `ENV` = `Production`
- **Environment Secrets**:
  - `SECRET_KEY` = `prod-secret-key-123`

#### Test Environment (`test`)
- **Name**: `test`
- **Protection Rules**:
  - Deployment branch: `release` only
- **Environment Variables**:
  - `ENV` = `Test`
- **Environment Secrets**:
  - `SECRET_KEY` = `test-secret-key-456`

#### Development Environment (`dev`)
- **Name**: `dev`
- **Protection Rules**:
  - Deployment branches: `develop` and `feature/**`
- **Environment Variables**:
  - `ENV` = `Development`
- **Environment Secrets**:
  - `SECRET_KEY` = `dev-secret-key-789`

### 3. Branch Structure

- **`main`** → Production environment (`prod`)
- **`release`** → Test environment (`test`)
- **`develop`** → Development environment (`dev`)
- **`feature/*`** → Development environment (`dev`)

### 4. Workflow

The workflow automatically:
1. Detects the branch being pushed
2. Maps it to the appropriate environment
3. Updates `config.json` with environment-specific values
4. Deploys to GitHub Pages

## How It Works

When you push to any tracked branch:
1. The workflow determines which environment to use based on the branch
2. It fetches the `ENV` variable and `SECRET_KEY` secret from that environment
3. Updates the `config.json` file with these values
4. Deploys the site to GitHub Pages

## Testing

1. Push to `develop` branch → Deploys with Development environment values
2. Push to `feature/new-feature` branch → Deploys with Development environment values
3. Push to `release` branch → Deploys with Test environment values
4. Push to `main` branch → Deploys with Production environment values (may require approval)

## Local Development

Simply open `index.html` in a browser. It will display default "xyz" values when `config.json` is empty.
