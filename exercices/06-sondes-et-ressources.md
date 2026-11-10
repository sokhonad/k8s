# Exercice 06 : Sondes de santé et ressources

**Durée :** 40 min · **Niveau :** intermédiaire

## Objectif

Permettre à Kubernetes de savoir si une application va bien, et limiter les ressources qu'elle consomme.

## Contexte

Un conteneur peut être démarré mais incapable de répondre (application bloquée, démarrage lent…). Kubernetes propose deux **sondes** :

| Sonde | Question posée | Si elle échoue |
|---|---|---|
| **readinessProbe** | « Es-tu prêt à recevoir du trafic ? » | Le pod est **retiré** du Service |
| **livenessProbe** | « Es-tu toujours vivant ? » | Le conteneur est **redémarré** |

On réserve aussi des ressources (**requests**) et on fixe un plafond (**limits**).

## Travail demandé

1. Ajoutez au conteneur nginx :
   - une **readinessProbe** HTTP sur `/`, port 80, toutes les 5 s ;
   - une **livenessProbe** HTTP sur `/`, port 80, toutes les 10 s ;
   - des **requests** de `50m` CPU et `32Mi` de mémoire ;
   - des **limits** de `200m` CPU et `128Mi` de mémoire.
2. Appliquez et vérifiez que tout fonctionne comme avant.
3. **Cassez la readinessProbe** : changez son chemin en `/nexiste-pas`. Appliquez et observez :
   - la colonne `READY` des pods ;
   - les endpoints du Service ;
   - la page http://localhost:30080.
4. Remettez le bon chemin, puis **cassez la livenessProbe** de la même façon. Observez la colonne `RESTARTS`.
5. Remettez tout en ordre.

## Critères de réussite

- [ ] Avec une readinessProbe cassée, les nouveaux pods restent à `0/1` et n'apparaissent pas dans les endpoints
- [ ] Avec une livenessProbe cassée, le compteur `RESTARTS` augmente
- [ ] À la fin, tous les pods sont `1/1` avec les deux sondes en place

## Questions

1. Pendant le test de la readinessProbe, pourquoi la page reste-t-elle accessible ? *(Indice : stratégie de mise à jour progressive.)*
2. Que signifie `50m` de CPU ?
3. Que se passe-t-il si un conteneur dépasse sa limite de mémoire ? Et sa limite de CPU ?

## Indices

<details>
<summary>Syntaxe des sondes</summary>

```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 2
  periodSeconds: 5
```
</details>

<details>
<summary>Observer les effets</summary>

```powershell
kubectl -n demo get pods -w
kubectl -n demo get endpoints hello-k8s
kubectl -n demo describe pod <nom-du-pod>     # section Events en bas
```
</details>

## Pour aller plus loin

- Quelle sonde utiliseriez-vous pour une application Java qui met une minute à démarrer ? Renseignez-vous sur la `startupProbe`.
