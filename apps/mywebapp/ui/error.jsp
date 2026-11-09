<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="_common.jspf" %>
<!doctype html>
<html lang="fr">
<head>
    <%= HEAD %>
    <title>MyWebApp · Erreur</title>
</head>
<body>
<%= nav("") %>

<main class="center">
    <div class="card result rise">
        <div class="card-body">
            <div class="result-icon ko">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18M6 6l12 12"/></svg>
            </div>
            <h1>Une erreur est survenue</h1>
            <p>L'opération n'a pas pu aboutir. La base de données est peut-être momentanément indisponible. Réessayez dans quelques instants.</p>
            <div class="actions">
                <a class="btn btn-primary" href="./">Retour à l'accueil</a>
            </div>
        </div>
    </div>
</main>
</body>
</html>
