# Exercice 11 : Changer le design sans recompiler

**Durée :** 60 min · **Niveau :** avancé

## Objectif

Remplacer l'interface de l'application Java par un design moderne, et faire en sorte que **chaque modification du design redéploie automatiquement** l'application.

## Contexte

- Tomcat compile lui-même les fichiers **JSP** au premier accès : on peut donc ajouter ou remplacer des pages sans toucher au code Java compilé.
- Quand une ConfigMap change, les pods qui l'utilisent **ne redémarrent pas**. Le **`configMapGenerator`** de Kustomize ajoute au nom de la ConfigMap une empreinte de son contenu. Si le contenu change, le nom change, le Deployment change, et Kubernetes recrée le pod.

```
fichier ui/ modifié ──> mywebapp-ui-<nouvelle empreinte> ──> Deployment modifié ──> nouveau pod
```

## Travail demandé

### Partie A : les pages

Dans `apps/mywebapp/ui/`, créez :

1. **`styles.css`** : une feuille de style commune, avec un **mode sombre** automatique et un affichage **mobile**.
2. **`index.jsp`** : la page d'accueil avec le formulaire d'inscription. Il doit garder les mêmes noms de champs (`username`, `email`, `city`, `date_of_birth`) et envoyer à `InsertUserServlet` en `POST`.
3. **`users.jsp`** : la liste des utilisateurs, lue directement dans la base, avec une recherche instantanée.
4. **`success.jsp`** : la page de confirmation. Le nom d'utilisateur doit être **échappé**.
5. **`error.jsp`** : la page d'erreur qui manquait dans le WAR.

### Partie B : le déploiement

6. Dans `kustomization.yaml`, générez une ConfigMap `mywebapp-ui` à partir des fichiers de `ui/`.
7. Montez-la dans l'initContainer et copiez les pages dans l'application `ROOT`.
8. Poussez sur GitHub.

### Partie C : vérifier

9. Modifiez une couleur dans `styles.css` et poussez. Observez dans ArgoCD :
   - le nom de la ConfigMap ;
   - le numéro de révision du Deployment ;
   - le nouveau ReplicaSet.
10. Testez la faille XSS : ouvrez `success.jsp?username=<script>alert(1)</script>`. Aucune alerte ne doit apparaître.

## Critères de réussite

- [ ] Les 4 pages s'affichent avec le nouveau design, en mode clair et en mode sombre
- [ ] L'inscription passe toujours par `InsertUserServlet`
- [ ] Une modification d'un fichier `ui/` poussée sur GitHub redéploie le pod **sans aucune commande**
- [ ] Le test XSS affiche le texte au lieu de l'exécuter

## Questions

1. Que se passerait-il sans `configMapGenerator`, avec une ConfigMap classique ?
2. Pourquoi les utilisateurs inscrits ne sont-ils pas perdus quand le pod de l'application est recréé ?
3. Qu'est-ce qu'une faille XSS, et pourquoi l'échappement la bloque-t-il ?

## Indices

<details>
<summary>configMapGenerator</summary>

```yaml
configMapGenerator:
  - name: mywebapp-ui
    namespace: mywebapp
    files:
      - ui/styles.css
      - ui/index.jsp
```

Dans le Deployment, référencez simplement `mywebapp-ui` : Kustomize remplace le nom automatiquement.
</details>

<details>
<summary>Lire la configuration de la base depuis une JSP</summary>

Les paramètres du `web.xml` sont accessibles avec `application.getInitParameter("dbUrl")`.
</details>

<details>
<summary>Partager du code entre plusieurs JSP</summary>

Placez les fonctions communes dans un fichier `_common.jspf`, dans un bloc `<%! ... %>`, et incluez-le avec :

```jsp
<%@ include file="_common.jspf" %>
```
</details>

## Pour aller plus loin

- Affichez en bas de chaque page le nom du pod qui a répondu, comme dans l'exercice 04.
