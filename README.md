# Apuntes IISSI-2

## Preparación del entorno

1. git clone https://github.eii.us.es/IISSI-2324/Proyecto-Examen-Lab
2. Coloca videos.sql en sql/ y edita settings.py
3. CREATE DATABASE IF NOT EXISTS examen_lab;
   CREATE USER IF NOT EXISTS 'iissi_user'@'localhost' IDENTIFIED BY 'iissi$user';
   GRANT ALL PRIVILEGES ON examen_lab.* TO 'iissi_user'@'localhost';
   FLUSH PRIVILEGES;
4. silence createdb / silence createapi / silence run
5. http://127.0.0.1:8081/api/v1/users/1
6. DESCRIBE Videos;


## EXAMEN 2

### 1. Mostrar todos los proyectos en formato de filas, incluyendo el avatar, username y edad del usuario asociado a cada proyecto.

Paso 1: El renderizador web/js/renderers/videos.js (lab4)
Paso 2: La página HTML web/video_details.html
Paso 3: La lógica JavaScript web/js/video_details.js (lab6)

        //getAll devuelve TODO de los usuarios
        let projects = await projectswithusersAPI_auto.getAll();
        //recorremos todos los proyectos
        for (let project of projects){
            projectContainer.appendChild(projectRenderer.asCard(project));
        }

### 2. El Ejercicio 2 pide un formulario para crear un proyecto nuevo.

Paso 1: Validador web/js/validators/projects.js
Paso 2: HTML web/create_project.html
Paso 3: JS web/js/create_project.js

        //handle
        let errors = videoValidator.validate(formData);
        document.getElementById("errors").innerHTML = "";
        if(errors.length > 0){
            for (let error of errors){
                messageRenderer.showErrorMessage(error);
            }
            return;
        }
        // Usuario logueado (valida)
        let logged = sessionManager.getLoggedUser();
        formData.append("userId", logged.userId);

### 3. Añadir un botón "Editar" en cada fila de projects.html que lleve a create_project.html?projectId=X

Parte 1: Botón en el renderizador
Parte 2: Modificar create_project.js
        let projectId = urlParams.get("projectId") fuera de las funciones
        let currentProject = null fuera de las funciones
        Una función loadCurrentProject() que rellena el formulario
        Modificar handleSubmit para hacer POST o PUT según si currentProject es null


## EXAMEN 3

### Ejercicio 1: vista auctions.html donde se muestren todas las subastas. Resaltar con bg-warning si name.length > 6

Paso 1: El renderizador web/js/renderers/auctions.js
        const resalta = auction.name.length > 6 ? "bg-warning" : "";
        <div class="card ${resalta} mt-4">
Paso 2: La página HTML web/auctions.html
Paso 3: La lógica JavaScript web/js/auctions.js
        let auctions = await auctionswithusersAPI_auto.getAll();
        for (let auction of auctions){
            auctionContainer.appendChild(auctionRenderer.asCard(auction));
        }

### Ejercicio 2: vista create_auction.html con formulario. Al cambiar name, mostrar diferencia de longitud.

Paso 1: Validador web/js/validators/auctions.js
Paso 2: HTML web/create_auction.html
        <small id="length-diff"></small>
Paso 3: JS web/js/create_auction.js

        async function main() {
            let registerForm = document.getElementById("form-auction");
            registerForm.onsubmit = handleSubmitauction;

            function updateDiff() {
                let name = document.getElementById("input-name").value;
                let seller = document.getElementById("input-seller").value;
                let diff = Math.abs(name.length - seller.length);
                document.getElementById("length-diff").textContent = `Diferencia de longitud con "seller": ${diff}`;
            }

            document.getElementById("input-name").addEventListener("input", updateDiff);
            document.getElementById("input-seller").addEventListener("input", updateDiff);
        }

        //VALIDACION
        let errors = auctionValidator.validate(formData);
        document.getElementById("errors").innerHTML="";
        if (errors.length > 0){
            for(let error of errors){
                messageRenderer.showErrorMessage(error);
            }
            return;
        }

        let logged = sessionManager.getLoggedUser();
        formData.append("userId", logged.userId);

### Ejercicio 3: Modificar create_auction.html para editar una subasta existente. Enlace desde auctions.html.

Paso 1: Enlace en el renderer
        <a href="create_auction.html?auctionId=${auction.auctionId}">${auction.startingPrice} €</a>
Parte 2: Modificar create_auction.js
        let auctionId = urlParams.get("auctionId") fuera de las funciones
        let currentauction = null fuera de las funciones
        Una función loadCurrentauction() que rellena el formulario
        Modificar handleSubmit para hacer POST o PUT según si currentauction es null


## EXAMEN 1 — Videos

### Ejercicio 1: Mostrar detalles de un vídeo (video_details.html?videoId=ID)

Paso 1: Renderizador web/js/renderers/videos.js (lab4)
        row justify-content-center
        col-md-6
Paso 2: La página HTML web/video_details.html
        Copia el index.html del proyecto.
        Cámbiale el <script> de index.js por video_details.js.
        Sustituye el contenido del <body> por tus tres divs.
Paso 3: La lógica JavaScript web/js/video_details.js (lab6)

### Ejercicio 2: Editar durationSeconds (entre 5 y 50000)

Paso 1: Crea el validador web/js/validators/videos.js (lab 5)
Paso 2: Añade el formulario al renderizador videos.js (lab 7)
Paso 3: Actualiza video_details.js (lab 7)
        let currentVideo = null;
        //load
        currentVideo = video;
        let form = document.getElementById("form-video");
        form.onsubmit = handleSubmit;
        //handle
        let errors = videoValidator.validate(formData);
        document.getElementById("errors").innerHTML = "";
        if(errors.length > 0){
            for (let error of errors){
                messageRenderer.showErrorMessage(error);
            }
            return;
        }

        //put necesita todos los campos
        formData.append("userId", currentVideo.userId);
        formData.append("title", currentVideo.title);
        formData.append("description", currentVideo.description);
        formData.append("recordingDate", currentVideo.recordingDate);
        if (currentVideo.thumbnailUrl) {
            formData.append("thumbnailUrl", currentVideo.thumbnailUrl);
        }

### Ejercicio 3: Modificar la página de índice

Paso 1: Importar sessionManager en index.js
        import { videosAPI_auto } from "/js/api/_videos.js";
        import { sessionManager } from "/js/utils/session.js";
Paso 2: Comprobar si el usuario está logueado en main (lab8)
        SÍ logueado:
        sessionManager.getLoggedUser()
        Contar sus vídeos con un for sobre videosAPI_auto.getAll()
        messageRenderer.showSuccessMessage("El usuario autenticado tiene " + count + " videos.")
Paso 4: Obtener los vídeos del usuario logueado si SÍ está logueado
        user.userId === loggedUser.userId
        usersRenderer.asLine(user, isLogged)
        loadUsers(loggedUser) o loadUsers(null) desde main()
Paso 5: Resaltar el usuario logueado en el listado
        let highlightClass = isLogged ? "bg-warning" : "";# Proyecto de examen
Este proyecto se usará como punto de partida en el examen de laboratorio de IISSI-2.