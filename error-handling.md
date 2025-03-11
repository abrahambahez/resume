## Errores por versiones desactualizadas

Para actualizar la librería principal `tlmgr` hay que correr un script en el directorio donde está el archivo binario:

```zsh
sudo cd /Library/TeX/texbin/
sudo ./update-tlmgr-latest.sh
# Si es necesario, hacer ejecutable con sudo chmod 755 ./update-tlmgr-latest.sh
```

Después de eso, es posible instalar correctamente paquetes faltantes.

El script se encuentra en:

<https://www.tug.org/texlive/tlmgr.html#disaster>

## Paquetes faltantes
Por ejemplo, el paquete `enumitem` se instala:

```bash
sudo tlmgr install enumitem
```
Y para el paquete `sectsty`:

```bash
sudo tlmgr install sectsty
```

