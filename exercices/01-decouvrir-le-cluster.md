# Exercice 01 : Découvrir le cluster

**Durée :** 20 min · **Niveau :** débutant

## Objectif

Démarrer un cluster Kubernetes local et savoir l'explorer avec `kubectl`.

## Contexte

Un **cluster** est un ensemble de machines (les **nœuds**) pilotées par un « cerveau » : le **control plane**. On ne parle jamais directement aux machines : on envoie des ordres au cluster avec `kubectl`, la « télécommande » de Kubernetes.

Docker Desktop fournit un cluster à **un seul nœud**, suffisant pour apprendre.

## Travail demandé

1. Activez Kubernetes dans Docker Desktop (méthode **Kubeadm**) et attendez que le voyant soit vert.
2. Sélectionnez le contexte du cluster local.
3. Affichez la liste des nœuds et vérifiez leur état.
4. Affichez la liste des namespaces.
5. Affichez **tous** les pods du cluster, tous namespaces confondus.
6. Remplissez le tableau suivant à partir de ce que vous observez dans le namespace `kube-system` :

| Pod | À quoi sert-il ? |
|---|---|
| `kube-apiserver-…` | |
| `etcd-…` | |
| `kube-scheduler-…` | |
| `kube-controller-manager-…` | |
| `coredns-…` | |
| `kube-proxy-…` | |

7. Ouvrez Docker Desktop → **Containers**. Pourquoi y voit-on des conteneurs dont le nom commence par `k8s_` ?

## Critères de réussite

- [ ] `kubectl get nodes` affiche un nœud `docker-desktop` à l'état `Ready`
- [ ] Vous savez lister les pods d'un namespace précis et de tous les namespaces
- [ ] Le tableau est rempli
- [ ] Vous savez expliquer le lien entre un pod Kubernetes et un conteneur Docker

## Indices

<details>
<summary>Commandes utiles</summary>

```powershell
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl get nodes
kubectl get namespaces
kubectl get pods -A
kubectl get pods -n kube-system
```
</details>

<details>
<summary>Le format des noms <code>k8s_…</code></summary>

`k8s_<conteneur>_<pod>_<namespace>_<uid>_<redémarrages>`

Chaque pod lancé par Kubernetes devient un ou plusieurs conteneurs dans le moteur Docker.
</details>

## Pour aller plus loin

- Lancez `kubectl describe node docker-desktop` : combien de CPU et de mémoire le nœud a-t-il ?
- Que signifie la colonne `RESTARTS` ? Un pod du control plane a-t-il redémarré ?
