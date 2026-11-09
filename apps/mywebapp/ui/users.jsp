<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="_common.jspf" %>
<%
    java.util.List<String[]> users = new java.util.ArrayList<String[]>();
    String dbError = null;
    try (java.sql.Connection c = openDb(application);
         java.sql.Statement st = c.createStatement();
         java.sql.ResultSet rs = st.executeQuery(
             "SELECT username, email, city, date_of_birth FROM users ORDER BY id DESC")) {
        while (rs.next()) {
            users.add(new String[] { rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4) });
        }
    } catch (Exception e) {
        dbError = e.getMessage();
    }
%>
<!doctype html>
<html lang="fr">
<head>
    <%= HEAD %>
    <title>MyWebApp · Utilisateurs</title>
</head>
<body>
<%= nav("users") %>

<main class="container">
    <div class="page-head rise">
        <div>
            <h1>Utilisateurs</h1>
            <p>Tous les membres inscrits, du plus récent au plus ancien.</p>
        </div>
        <a class="btn btn-primary" href="./">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M12 5v14M5 12h14"/></svg>
            Nouvel utilisateur
        </a>
    </div>

    <% if (dbError != null) { %>
        <div class="alert">
            <strong>Base de données indisponible.</strong>&nbsp;<%= esc(dbError) %>
        </div>
    <% } %>

    <div class="card rise rise-2">
        <% if (users.isEmpty()) { %>
            <div class="empty">
                <div class="empty-icon">
                    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
                <h3>Aucun utilisateur pour l'instant</h3>
                <p>Soyez le premier à rejoindre la plateforme.</p>
                <a class="btn btn-primary" href="./">Créer un compte</a>
            </div>
        <% } else { %>
            <div class="toolbar">
                <div class="input-wrap">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/></svg>
                    <input class="input" id="search" type="search" placeholder="Rechercher un nom, un e-mail, une ville…">
                </div>
                <span class="badge" id="count"><%= users.size() %> membre<%= users.size() > 1 ? "s" : "" %></span>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr><th>Utilisateur</th><th>Ville</th><th>Date de naissance</th></tr>
                    </thead>
                    <tbody id="rows">
                    <% for (String[] u : users) { %>
                        <tr>
                            <td>
                                <div class="user">
                                    <span class="avatar" style="background:<%= avatarColor(u[0]) %>"><%= initials(u[0]) %></span>
                                    <div>
                                        <div class="user-name"><%= esc(u[0]) %></div>
                                        <div class="muted"><%= esc(u[1]) %></div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="chip">📍 <%= esc(u[2]) %></span></td>
                            <td class="muted"><%= esc(u[3]) %></td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>
</main>

<footer class="footer">Servi par le pod <code><%= esc(java.net.InetAddress.getLocalHost().getHostName()) %></code></footer>

<script>
    (function () {
        var search = document.getElementById('search');
        if (!search) return;
        var rows = Array.prototype.slice.call(document.querySelectorAll('#rows tr'));
        var count = document.getElementById('count');
        search.addEventListener('input', function () {
            var q = search.value.trim().toLowerCase();
            var visible = 0;
            rows.forEach(function (r) {
                var show = r.textContent.toLowerCase().indexOf(q) !== -1;
                r.style.display = show ? '' : 'none';
                if (show) visible++;
            });
            count.textContent = visible + ' membre' + (visible > 1 ? 's' : '');
        });
    })();
</script>
</body>
</html>
