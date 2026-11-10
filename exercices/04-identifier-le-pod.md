# Exercice 04 : Quel pod m'a répondu ?

**Durée :** 30 min · **Niveau :** intermédiaire

## Objectif

Afficher sur la page le **nom** et l'**IP du pod** qui a répondu, pour observer la répartition de charge du Service.

## Contexte

Une page HTML statique ne connaît pas le pod qui la sert. nginx sait cependant insérer des variables dans une page au moment de l'envoyer, grâce aux **SSI** (*Server Side Includes*) :

```html
<!--# echo var="hostname" -->
```

Dans Kubernetes, le *hostname* d'un conteneur est **le nom de son pod**.

Les SSI sont désactivés par défaut : il faut fournir à nginx sa propre configuration.

## Travail demandé

1. Dans la ConfigMap, ajoutez à la page :
   - le nom du pod (variable `hostname`) ;
   - l'IP du pod (variable `server_addr`).
2. Ajoutez à la ConfigMap une clé `default.conf` : une configuration nginx qui :
   - écoute sur le port 80 ;
   - sert le dossier `/usr/share/nginx/html` ;
   - active les SSI ;
   - désactive le cache navigateur (en-tête `Cache-Control: no-store`).
3. Dans le Deployment :
   - montez `index.html` dans `/usr/share/nginx/html` ;
   - montez `default.conf` dans `/etc/nginx/conf.d`.
   Chaque dossier ne doit recevoir **que** son fichier.
4. Appliquez, puis faites 10 requêtes d'affilée et notez quels pods répondent.

## Critères de réussite

- [ ] La page affiche un nom de pod qui existe dans `kubectl -n demo get pods`
- [ ] Sur 10 requêtes, **au moins deux pods différents** répondent
- [ ] `/etc/nginx/conf.d` ne contient que `default.conf`

## Questions

1. Pourquoi votre navigateur affiche-t-il souvent le même pod, alors que `curl` alterne ?
2. Pourquoi ne pas monter toute la ConfigMap dans les deux dossiers ?

## Indices

<details>
<summary>Configuration nginx</summary>

```nginx
server {
  listen 80;
  location / {
    root /usr/share/nginx/html;
    index index.html;
    ssi on;
    add_header Cache-Control "no-store";
  }
}
```
</details>

<details>
<summary>Ne monter qu'une clé de la ConfigMap</summary>

```yaml
volumes:
  - name: html
    configMap:
      name: hello-k8s-html
      items:
        - key: index.html
          path: index.html
```
</details>

<details>
<summary>Faire 10 requêtes en PowerShell</summary>

```powershell
1..10 | % { (curl.exe -s http://localhost:30080) -match "Pod : <strong>(.*?)</strong>" | Out-Null; $Matches[1] }
```
</details>

## Pour aller plus loin

- Ajoutez la date et l'heure du serveur avec la variable SSI `date_local`.
