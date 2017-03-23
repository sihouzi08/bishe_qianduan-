/**
 * Created by ClownMonkey on 2017/1/16.
 */
function get(page,size,sort,operation,key,value) {
    $.ajax({
        url: "http://101.200.56.75/shop/newspage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value,
        type: "GET",
        dataType: "json",
        success: function (res) {
            p = res.payload.content;
            maxpage = res.payload.totalPages;
            $("#pager").html("");
            $("#ShopTable  tr:not(:first)").html("");
            page++;
            addElementLiFirstAndUpone("pager",operation,key,value,page);
            var ShopTable = document.getElementById("ShopTable");
            for (var i = 0; i < p.length; i++) {
                var row = ShopTable.insertRow(ShopTable.rows.length);
                var c1 = row.insertCell(0);
                c1.innerHTML = (page - 1) * 5 + i + 1;
                var c2 = row.insertCell(1);
                c2.innerHTML = p[i].shopname;
                var c3 = row.insertCell(2);
                c3.innerHTML = p[i].des;
                var c4 = row.insertCell(3);
                c4.innerHTML = p[i].price;
                var c5 = row.insertCell(4);
                c5.innerHTML = p[i].shop_status;
                var c6 = row.insertCell(5);
                c6.innerHTML = p[i].picture;
                var c7 = row.insertCell(6);
                c7.innerHTML = "<a href='#' title='修改商品'"
                    + "onclick=\"change('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].des + "','" + p[i].price + "')\">"
                    + "<span class='glyphicon glyphicon-cog'></span>"
                    + "</a>"
                    + "<a href='#' title='查看商品'"
                    + "onclick=\"detail('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].des + "','" + p[i].price + "')\">"
                    + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                    + "</a>"
                    + "<a href='#' title='已售商品'"
                    + "onclick=\"status('"  + p[i].shopid + "','" + p[i].shop_status  + "')\">"
                    + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                    + "</a>";

            }

            for (var i = 1; i < maxpage + 1; i++) {
                addElementLi("pager", i,operation,key,value);
            }

//                    page--;
            addElementLiNextAndEnd("pager",operation,key,value,page);

//                    addElementLiEnd("pager",operation,key,value);

            alert("remond()")
        }

    });
    alert("remond()kuayu()")
}

