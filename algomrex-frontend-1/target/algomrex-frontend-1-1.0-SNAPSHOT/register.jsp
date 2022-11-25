<!DOCTYPE html>
<html>
<head>
    <title>Page Title</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
</head>
<body style="background-color: #E5E4E2; margin: 20px; font-family: 'Montserrat'; ">

<div class="row">
    <div class="col-lg-4">
        
    </div>
    <div class="col-lg-4" style="text-align: center">
<img src="assests/logo.png" style="width: 50%">
        <h3>Algomrex</h3>
        <h4 id="userRegistrationResult"></h4>
    </div>
    <div class="col-lg-4">

    </div>
</div>

<div class="row">
    <div class="col-lg-5">

    </div>
    <div class="col-lg-2">
        <form id="userRegistration">
            <div class="form-outline mb-4">
                <input type="text" id="firstName" class="form-control" />
                <label class="form-label" for="firstName">First Name</label>
            </div>
            <div class="form-outline mb-4">
                <input type="text" id="lastName" class="form-control" />
                <label class="form-label" for="lastName">Last Name</label>
            </div>
            <div class="form-outline mb-4">
                <input type="text" id="username" class="form-control" />
                <label class="form-label" for="username">Username</label>
            </div>
            <div class="form-outline mb-4">
                <input type="text" id="password" class="form-control" />
                <label class="form-label" for="password">Password</label>
            </div>
            <button type="submit" class="btn btn-primary btn-block mb-4">Register</button>
            <div class="text-center">
                <p>Already a member? <a href="#!">Login</a></p>
            </div>
        </form>
    </div>
    <div class="col-lg-5">

    </div>

</div>
<div class="row" style="margin-top: 20px ">
</div>
<div class="row" style="margin-top: 20px ">
</div>


</body>
<script src="js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>

    $("#userRegistration").submit(function(e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: baseUrl+'userRegistration',
            data: JSON.stringify({firstName : $('#firstName').val().toString(),
                lastName: $('#lastName').val().toString(),
                username : $('#username').val().toString(),
                password: $('#password').val().toString()}),
            success: function(results)
            {
                $('#userRegistrationResult').html(results.Message);
            }
        });

    });


</script>

</html>