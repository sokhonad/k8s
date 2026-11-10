# Exercice 05 : Passer à l'échelle et s'auto-réparer

**Durée :** 30 min · **Niveau :** débutant

## Objectif

Changer le nombre de copies d'une application et constater que Kubernetes répare tout seul ce qui casse.

## Contexte

Un Deployment ne crée pas les pods lui-même : il crée un **ReplicaSet**, dont le seul travail est de garantir qu'il y a **toujours** le bon nombre de pods.

```
Deployment ──> ReplicaSet ──> Pods
 (la version)   (le nombre)    (les conteneurs)
```

## Travail demandé

### Partie A : passer à l'échelle

1. Passez l'application à **4 replicas** en modifiant le fichier YAML, puis appliquez.
2. Vérifiez qu'il y a 4 pods, et que les 4 répondent sur la page (exercice 04).
3. Passez à 1 replica avec `kubectl scale`, sans toucher au fichier.
4. Réappliquez le fichier YAML. Combien de pods obtenez-vous ? Pourquoi ?

### Partie B : auto-réparation

5. Dans un premier terminal, surveillez les pods en continu.
6. Dans un second terminal, supprimez un pod.
7. Observez ce qui se passe dans le premier terminal.
8. Supprimez **tous** les pods d'un coup. La page reste-t-elle accessible ?

## Critères de réussite

- [ ] 4 pods `Running`, tous visibles via la page
- [ ] Un pod supprimé est remplacé automatiquement par un pod au **nouveau nom**
- [ ] Vous savez expliquer le rôle du ReplicaSet

## Questions

1. Le nom du nouveau pod est-il identique à l'ancien ? Quelle partie du nom change ?
2. Quelle est la différence entre modifier `replicas` dans le fichier et utiliser `kubectl scale` ?
3. Combien de ReplicaSets voyez-vous avec `kubectl -n demo get rs` ? Pourquoi ?

## Indices

<details>
<summary>Commandes utiles</summary>

```powershell
kubectl -n demo get pods -w                          # surveiller (Ctrl+C pour arrêter)
kubectl -n demo delete pod <nom-du-pod>
kubectl -n demo delete pods -l app=hello-k8s         # tous les pods de l'app
kubectl -n demo scale deploy/hello-k8s --replicas=1
kubectl -n demo get rs
```
</details>

## Pour aller plus loin

- Passez à 20 replicas. Que se passe-t-il ? Regardez `kubectl -n demo describe pod <un-pod-Pending>` si certains restent en `Pending`.
