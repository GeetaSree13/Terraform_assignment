provider "google" {
    project = "tonal-benefit-462606-b8"
    region = "asia-southeast1"
    zone   = "asia-southeast1-a"
    credentials = file("/home/atlantis/.atlantis/repos/GeetaSree13/Terraform_assignment/creds.json")
}