# Exercice 02 : Premier déploiement

**Durée :** 40 min · **Niveau :** débutant

## Objectif

Écrire ses premiers fichiers YAML pour lancer un serveur web et le rendre accessible depuis le navigateur.

## Contexte

Trois ressources suffisent pour publier une application :

| Ressource | Rôle |
|---|---|
| **Namespace** | Un espace isolé pour ranger les ressources de l'application |
| **Deployment** | Décrit **quoi lancer** (image, nombre de copies) et garde les pods en vie |
| **Service** | Donne une **adresse stable** aux pods et répartit le trafic entre eux |

## Travail demandé

Dans un dossier `k8s/`, créez trois fichiers :

1. **`namespace.yaml`** : un namespace `demo`.
2. **`deployment.yaml`** : un Deployment `hello-k8s` dans `demo` qui :
   - lance **2 pods** de l'image `nginx:1.27-alpine` ;
   - expose le port `80` du conteneur ;
   - pose le label `app: hello-k8s` sur les pods.
3. **`service.yaml`** : un Service `hello-k8s` de type **NodePort** qui :
   - envoie le trafic aux pods portant le label `app: hello-k8s` ;
   - est accessible sur le port **30080** de la machine.

Puis :

4. Appliquez les trois fichiers, dans le bon ordre.
5. Attendez que le déploiement soit terminé.
6. Ouvrez http://localhost:30080.

## Critères de réussite

- [ ] `kubectl -n demo get pods` affiche **2 pods** `Running` et `1/1`
- [ ] `kubectl -n demo get svc` affiche le port `80:30080/TCP`
- [ ] http://localhost:30080 affiche la page « Welcome to nginx! »

## Questions

1. Que se passe-t-il si le `selector` du Service ne correspond pas au label des pods ? Testez-le.
2. Pourquoi faut-il créer le namespace **avant** le Deployment ?
3. Quelle est la différence entre `port`, `targetPort` et `nodePort` dans le Service ?

## Indices

<details>
<summary>Squelette du Deployment</summary>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-k8s
  namespace: demo
spec:
  replicas: ?
  selector:
    matchLabels:
      app: ?
  template:
    metadata:
      labels:
        app: ?
    spec:
      containers:
        - name: nginx
          image: ?
          ports:
            - containerPort: ?
```
</details>

<details>
<summary>Commandes utiles</summary>

```powershell
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl -n demo rollout status deployment/hello-k8s
kubectl -n demo get endpoints hello-k8s
```
</details>

<details>
<summary>La connexion est refusée juste après le déploiement</summary>

C'est normal pendant quelques secondes, le temps que le port NodePort soit ouvert. Réessayez.
</details>

## Pour aller plus loin

- Affichez les logs nginx : `kubectl -n demo logs deploy/hello-k8s`
- Supprimez tout avec une seule commande, sans supprimer les fichiers un par un.
