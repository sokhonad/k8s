<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="_common.jspf" %>
<%
    int userCount = -1;
    int cityCount = 0;
    try (java.sql.Connection c = openDb(application);
         java.sql.Statement st = c.createStatement();
         java.sql.ResultSet rs = st.executeQuery("SELECT COUNT(*), COUNT(DISTINCT city) FROM users")) {
        if (rs.next()) { userCount = rs.getInt(1); cityCount = rs.getInt(2); }
    } catch (Exception e) {
        // Base indisponible : la page reste affichée sans statistiques
    }
%>
<!doctype html>
<html lang="fr">
<head>
    <%= HEAD %>
    <title>MyWebApp · Inscription</title>
</head>
<body>
<%= nav("home") %>

<main class="container">
    <section class="hero">
        <div class="rise">
            <span class="eyebrow"><span class="dot"></span>En ligne sur Kubernetes</span>
            <h1>Rejoignez la <span class="gradient-text">communauté</span> en quelques secondes.</h1>
            <p class="lead">Créez votre profil, retrouvez tous les membres inscrits et suivez la croissance de la plateforme en temps réel.</p>

            <div class="stats">
                <div class="stat">
                    <div class="stat-value"><%= userCount >= 0 ? String.valueOf(userCount) : "—" %></div>
                    <div class="stat-label">Membres inscrits</div>
                </div>
                <div class="stat">
                    <div class="stat-value"><%= userCount >= 0 ? String.valueOf(cityCount) : "—" %></div>
                    <div class="stat-label">Villes représentées</div>
                </div>
            </div>
        </div>

        <div class="card rise rise-2">
            <div class="card-body">
                <h2 class="card-title">Créer un compte</h2>
                <p class="card-sub">Tous les champs sont obligatoires.</p>

                <form action="InsertUserServlet" method="post" autocomplete="on">
                    <div class="field">
                        <label for="username">Nom d'utilisateur</label>
                        <div class="input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                            <input class="input" type="text" id="username" name="username" placeholder="ex : aminata" required maxlength="100">
                        </div>
                    </div>
                    <div class="field">
                        <label for="email">Adresse e-mail</label>
                        <div class="input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="m22 7-10 6L2 7"/></svg>
                            <input class="input" type="email" id="email" name="email" placeholder="vous@exemple.com" required maxlength="200">
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="city">Ville</label>
                            <div class="input-wrap">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0z"/><circle cx="12" cy="10" r="3"/></svg>
                                <input class="input" type="text" id="city" name="city" placeholder="Dakar" required maxlength="100">
                            </div>
                        </div>
                        <div class="field">
                            <label for="date_of_birth">Date de naissance</label>
                            <div class="input-wrap">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
                                <input class="input" type="date" id="date_of_birth" name="date_of_birth" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">
                        Créer mon compte
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14M13 5l7 7-7 7"/></svg>
                    </button>
                </form>
            </div>
        </div>
    </section>
</main>

<footer class="footer">Servi par le pod <code><%= esc(java.net.InetAddress.getLocalHost().getHostName()) %></code></footer>
</body>
</html>
