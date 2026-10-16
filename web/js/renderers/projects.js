"use strict";
import { parseHTML } from "/js/utils/parseHTML.js";

const projectRenderer = {
    asCard: function(project) {
        let html = 
        `<div class="card mt-4">
            <div class= "row">
                <div class="col-md-4">
                    <img src="${project.imageUrl}" class="card-img-top">
                </div>
                <div class= "col-md-8">
                    <h5>${project.name}</h5>
                    <p>${project.description}</p>
                    <div class="row">
                        <div class="col-auto">
                            <img src="${project.avatarUrl}" class="rounded-circle" style="width:40px">
                        </div>
                        <div class="col-auto">
                            <p>@${project.username} - ${project.age}</p>
                        </div>
                    </div>
                </div>
            </div>
            <a href="create_project.html?projectId=${project.projectId}" 
            class="btn btn-primary">Editar</a>
        </div>`;

    let card = parseHTML(html);
    return card;
    }
};

export { projectRenderer };
