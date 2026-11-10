# Exercice 03 : Servir sa propre page

**Durée :** 40 min · **Niveau :** débutant

## Objectif

Remplacer la page par défaut de nginx par votre propre page HTML, **sans construire d'image Docker**.

## Contexte

Une **ConfigMap** stocke du texte (de la configuration, des fichiers) en dehors de l'image. On la « branche » ensuite dans le conteneur comme un dossier, grâce à un **volume**.

```
ConfigMap ──(volume)──> dossier dans le conteneur ──> lu par l'application
```

L'image `nginx` sert les fichiers du dossier `/usr/share/nginx/html`.

## Travail demandé

1. Créez **`k8s/configmap.yaml`** : une ConfigMap `hello-k8s-html` dans `demo`, avec une clé `index.html` qui contient une page HTML à votre goût (un titre et un paragraphe suffisent).
2. Modifiez **`k8s/deployment.yaml`** :
   - déclarez un volume `html` qui provient de la ConfigMap ;
   - montez ce volume dans `/usr/share/nginx/html` du conteneur nginx.
3. Appliquez les fichiers et vérifiez votre page sur http://localhost:30080.
4. Modifiez le titre dans la ConfigMap et réappliquez. La page change-t-elle tout de suite ?
5. Forcez la prise en compte en redémarrant les pods.

## Critères de réussite

- [ ] http://localhost:30080 affiche **votre** page
- [ ] Vous pouvez lire votre fichier depuis l'intérieur d'un pod :
  `kubectl -n demo exec deploy/hello-k8s -- cat /usr/share/nginx/html/index.html`
- [ ] Vous savez expliquer comment le nom `html` relie `volumes` et `volumeMounts`

## Questions

1. Pourquoi est-il intéressant de ne pas mettre la page dans l'image Docker ?
2. Combien de temps faut-il pour qu'une modification de la ConfigMap soit visible sans redémarrage ?
3. Que devient le contenu d'origine de `/usr/share/nginx/html` une fois le volume monté ?

## Indices

<details>
<summary>Écrire un fichier sur plusieurs lignes en YAML</summary>

```yaml
data:
  index.html: |
    <!doctype html>
    <html>...</html>
```

Le `|` conserve les retours à la ligne.
</details>

<details>
<summary>Volumes et montages</summary>

```yaml
spec:
  template:
    spec:
      containers:
        - name: nginx
          volumeMounts:
            - name: html
              mountPath: /usr/share/nginx/html
      volumes:
        - name: html
          configMap:
            name: hello-k8s-html
```
</details>

<details>
<summary>Redémarrer les pods</summary>

```powershell
kubectl -n demo rollout restart deployment/hello-k8s
```
</details>

## Pour aller plus loin

- Ajoutez une deuxième page `about.html` dans la même ConfigMap et accédez-y via http://localhost:30080/about.html.
