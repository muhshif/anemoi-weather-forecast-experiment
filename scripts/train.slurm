#!/bin/bash
#SBATCH --job-name=hackathon-train
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=20
#SBATCH --output=hackathon-train-%j.out
#SBATCH --error=hackathon-train-%j.err
set -euo pipefail
: "${HACKATHON_ROOT:?Set the absolute path to hackathon}"
cd "$HACKATHON_ROOT/configs"
export HYDRA_FULL_ERROR=1
anemoi-training config validate --config-name hackathon_forecast
anemoi-training train --config-name hackathon_forecast
