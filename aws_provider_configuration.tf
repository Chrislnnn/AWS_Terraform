# Konfiguration vom AWS Profivder
# Die Standard Region für die Ressourcen soll eu-central-1 sein
provider "aws" {
  region  = var.aws_region
  profile = "chrislnnn"
}

# Für das ACM-Zertifikat wird ausschließlich us-east-1 akzeptiert
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "chrislnnn"
}