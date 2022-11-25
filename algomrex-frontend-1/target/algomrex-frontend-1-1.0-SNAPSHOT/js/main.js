










var baseUrl = "http://localhost:8086/Algomrex/";


var headers,
    rowHeaders;

var randomStartingPoint = "";

function isChecked(product, resource, data) {
    let country = data.find(el => el.rowHeader === product && el.header === resource);
    if (typeof country === 'undefined') {
        return "-";
    } else {
        return country.weight;
    }
}

function getTableData(gameUrl) {
    $("#table").empty();
    data = [];
    $.ajax({
        url: gameUrl,
        type: 'GET',
        contentType: "application/json",
        data: {},
        success: function (results) {
            console.log(results.Data);
            setRandomDistanceTable(results.Data);
        },
        error: function (xhr) {

        }

    });
}


function setRandomDistanceTable(Data) {
    let table = document.createElement("table"),
        tr = document.createElement("tr"),
        th = document.createElement("th")

    th.innerHTML = '&nbsp;';
    tr.appendChild(th);
    headers.forEach(function (c, j) {
        th = document.createElement("th");
        th.innerHTML = c;
        tr.appendChild(th);
    });
    table.appendChild(tr);
    rowHeaders.forEach(function (r, i) {
        tr = document.createElement("tr");
        let td = document.createElement("td");
        td.innerHTML = r;
        tr.appendChild(td);
        headers.forEach(function (c, j) {
            td = document.createElement("td");
            td.innerHTML = isChecked(c, r, Data);
            tr.appendChild(td);
        });
        table.appendChild(tr);
    });
    document.getElementById('table').appendChild(table);
    randomStartingPoint = rowHeaders[Math.floor(Math.random()*rowHeaders.length)];
    $("#startingPoint").html("<b>"+randomStartingPoint+"</b>");


    $.each(Data, function (index, value) {
        if(value.header !== "Weight"){
            let tagOption = ('<option value=' + value.weight + '>' + value.rowHeader + '</option>');
            $('#choices-multiple-remove-button').append(tagOption);
        }
    });
    let multipleCancelButton = new Choices('#choices-multiple-remove-button', {removeItemButton: true,});
}


function setCookie(cname,cvalue,exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for(let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
