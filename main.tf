provider "vault" {}
data "vault_generic_secret" "gcp_auth" {
    //path = "gcp_one/key${var.roleset}"
    path = "gcp_one/token/project-token-roleset"
}

provider "google" {
    credentials = base64decode(data.vault_generic_secret.gcp_auth.data.private_key_data)
   // access_token = data.vault_generic_secret.gcp_auth.data["token"]
    project = var.project_name
}


output "token" {
    value = data.vault_generic_secret.gcp_auth.data
}
variable "roleset" {
    type = string
    default = "concrete-flare-310318"
}

