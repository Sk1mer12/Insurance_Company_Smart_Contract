let myInterval;
    i=1;
    function start_random(){
    
    console.log("Reading nº: " + i);

        if(i==1){
            af=0;
            bf=0;
            cf=0;
            df=0;
            ef=0;
            ff=0;
            gf=0;
            a_=Math.floor(Math.random() * 200)
            b_=Math.floor(Math.random() * 100)
            c_=Math.floor(Math.random() * 30)
            d_=Math.floor(Math.random() * 30)
            e_=Math.floor(Math.random() * 30)
            f_= Math.floor(Math.random() * 30)
            g_=Math.floor(Math.random() * 50)

            a = document.getElementById("speed_traffic_highway").innerHTML = "speed_traffic_highway: " + a_
            b = document.getElementById("speed_traffic_village").innerHTML = "speed_traffic_village: " + b_
            c = document.getElementById("headways_between_vehicles").innerHTML = "headways_between_vehicles: " + c_
            d = document.getElementById("acceleration").innerHTML = "acceleration: " + d_
            e = document.getElementById("deceleration").innerHTML = "deceleration: " + e_
            f = document.getElementById("overtaking_lane_changing").innerHTML = "overtaking_lane_changing: " + f_
            g = document.getElementById("traffic_regulations").innerHTML = "traffic_regulations: " + g_

            af=af+a_
            bf=bf+b_
            cf=cf+c_
            df=df+d_
            ef=ef+e_
            ff=ff+f_
            gf=gf+g_

            console.log(a)
            console.log(b)
            console.log(c)
            console.log(d)
            console.log(e)
            console.log(f)
            console.log(g)
            console.log("")
        }
        else if(i==30){
            af=af/i
            bf=bf/i
            cf=cf/i
            df=df/i
            ef=ef/i
            ff=ff/i
            gf=gf/i

            document.getElementById("speed_traffic_highway").innerHTML = "speed_traffic_highway_average: " + af.toFixed(2)
            document.getElementById("speed_traffic_village").innerHTML = "speed_traffic_village_average: " + bf.toFixed(2)
            document.getElementById("headways_between_vehicles").innerHTML = "headways_between_vehicles_average: " + cf.toFixed(2)
            document.getElementById("acceleration").innerHTML = "acceleration_average: " + df.toFixed(2)
            document.getElementById("deceleration").innerHTML = "deceleration_average: " + ef.toFixed(2)
            document.getElementById("overtaking_lane_changing").innerHTML = "overtaking_lane_changing_average: " + ff.toFixed(2)
            document.getElementById("traffic_regulations").innerHTML = "traffic_regulations_average: " + gf.toFixed(2)
            console.log(a)
            console.log(b)
            console.log(c)
            console.log(d)
            console.log(e)
            console.log(f)
            console.log(g)
            console.log("")
            console.log("Average Reading")
            console.log("speed_traffic_highway_average: " + af.toFixed(2))
            console.log("speed_traffic_village_average: " +bf.toFixed(2))
            console.log("headways_between_vehicles_average: " + cf.toFixed(2))
            console.log("acceleration_average: " + df.toFixed(2))
            console.log("deceleration_average: " + ef.toFixed(2))
            console.log("overtaking_lane_changing_average: " + ff.toFixed(2))
            console.log("traffic_regulations_average: " + gf.toFixed(2))    
            clearTimeout(myInterval);
            return "Ended";
        }
        else{
            a_=Math.floor(Math.random() * 200)
            b_=Math.floor(Math.random() * 100)
            c_=Math.floor(Math.random() * 30)
            d_=Math.floor(Math.random() * 30)
            e_=Math.floor(Math.random() * 30)
            f_= Math.floor(Math.random() * 30)
            g_=Math.floor(Math.random() * 50)

            a = document.getElementById("speed_traffic_highway").innerHTML = "speed_traffic_highway: " + a_
            b = document.getElementById("speed_traffic_village").innerHTML = "speed_traffic_village: " + b_
            c = document.getElementById("headways_between_vehicles").innerHTML = "headways_between_vehicles: " + c_
            d = document.getElementById("acceleration").innerHTML = "acceleration: " + d_
            e = document.getElementById("deceleration").innerHTML = "deceleration: " + e_
            f = document.getElementById("overtaking_lane_changing").innerHTML = "overtaking_lane_changing: " + f_
            g = document.getElementById("traffic_regulations").innerHTML = "traffic_regulations: " + g_

            af=af+a_
            bf=bf+b_
            cf=cf+c_
            df=df+d_
            ef=ef+e_
            ff=ff+f_
            gf=gf+g_

            console.log(a)
            console.log(b)
            console.log(c)
            console.log(d)
            console.log(e)
            console.log(f)
            console.log(g)
            console.log("")
        }
        myInterval = setTimeout(start_random, 1000);

        i++;
    }


    function stop_random(){
        document.getElementById("speed_traffic_highway").innerHTML = ""
        document.getElementById("speed_traffic_village").innerHTML = ""
        document.getElementById("headways_between_vehicles").innerHTML = ""
        document.getElementById("acceleration").innerHTML = ""
        document.getElementById("deceleration").innerHTML = ""
        document.getElementById("overtaking_lane_changing").innerHTML =""
        document.getElementById("traffic_regulations").innerHTML = ""
        clearTimeout(myInterval);
        console.clear();
        i=1;
    }