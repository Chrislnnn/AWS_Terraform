# Konfiguration vom Backend
terraform {
  backend "s3" {
    encrypt      = true

    # Meine erstellte S3-Bucket
    bucket       = "iubh-terraform-bucket"

    # Name der State-Datei in der Bucket
    key          = "terraform.tfstate"

    # Festlegung der AWS Region, in der alles gespeichert wird (wichtig für Latenz)
    region       = "eu-central-1"

    # Mein Profil für den Zugriff
    profile      = "chrislnnn"
  }
}