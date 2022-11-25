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

</form>

<div class="row">
    <div class="col-lg-12" style="text-align: center">
        <img src="assests/logo.png">
    </div>
    <div class="col-lg-12" style="text-align: center">

        <h1 style="font-weight: bold">Welcome to Algomrex IQ Game</h1>
        <p>Please Choose a Game!!!</p>
    </div>
</div>

<div class="row">

    <div class="col-lg-12" style="text-align: center">
        <button type="button" class="btn btn-primary" onclick="startTheGame('1')">Knapsack Problem</button>
        <button type="button" class="btn btn-secondary" onclick="startTheGame('2')">Find Shortest Path</button>
        <button type="button" class="btn btn-success" onclick="startTheGame('3')">Find Minimum Connectors</button>
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
    function startTheGame(gameId){
        if(gameId === '1'){
           location.href='knapsack.jsp';
        }else if(gameId === '2'){
            location.href='shortestPath.jsp';
        }else if(gameId === '3'){
            location.href='minimumConnector.jsp';
        }
    }
</script>
<script>
    $(document).ready(function() {
        if(getCookie('userId') === 'null'){
            location.href='index.jsp';
        }
    });

</script>
</html>