<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="_common.jspf" %>
<!doctype html>
<html lang="fr">
<head>
    <%= HEAD %>
    <title>MyWebApp · Compte créé</title>
</head>
<body>
<%= nav("") %>

<main class="center">
    <div class="card result rise">
        <div class="card-body">
            <div class="result-icon ok">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"/></svg>
            </div>
            <h1>Bienvenue à bord !</h1>
            <p>Le compte <strong><%= esc(request.getParameter("username")) %></strong> a bien été ajouté à la base de données.</p>
            <div class="actions">
                <a class="btn btn-primary" href="users.jsp">Voir les utilisateurs</a>
                <a class="btn btn-ghost" href="./">Ajouter un autre</a>
            </div>
        </div>
    </div>
</main>
</body>
</html>
