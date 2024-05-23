<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<title>Insert title here</title>

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <button type="button" class="navbar-toggler" 
            data-bs-toggle="collapse" 
            data-bs-target="#bs-example-navbar-collapse-1" 
            aria-controls="bs-example-navbar-collapse-1"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">JSP</a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="index.jsp">MAIN</a></li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp">PAGE</a></li>
            </ul>
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                        role="button" data-bs-toggle="dropdown"
                        aria-expanded="false">CONNECT</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="login.jsp">LOGIN</a></li>
                        <li><a class="dropdown-item" href="register.jsp">SIGNUP</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
 <div class="container">
    <div class="row">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="loginAction.jsp">
                    <h3 style="text-align: center;">LoginPage</h3>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="id" name="userID" maxlength="20">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="pw" name="userPw" maxlength="20">
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="login">
                </form>
            </div>
        </div>
        <div class="col-lg-4"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
