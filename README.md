# dotfiles

My workflow configuration.
Portable dotfiles repo para migrar setup desde Omarchy a Ubuntu WSL2 sin tocar entorno actual.

## Flujo

1. Importar archivos base desde home actual (solo safelist):
   ```bash
   ./scripts/import-from-home.sh
   ```
2. Revisar cambios y commitear.
3. En WSL2:
   ```bash
   git clone git@github.com:Quiarom/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ./install.sh wsl --dry-run
   ./install.sh wsl
   ./check.sh
   ```

## Estructura

- `common/home/`: links para Linux general.
- `wsl/home/`: overrides específicos WSL2.
- `packages/`: listas declarativas.
- `scripts/`: utilidades de import/link.
- `secrets/`: placeholders, nunca secretos reales.

## Seguridad

- No subir keys, tokens, `.env`, dumps, kube/aws creds.
- Secretos deben inyectarse manualmente en destino.
