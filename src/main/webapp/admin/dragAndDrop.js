export function addDropAndDragToRow(row) {
    row.draggable = true;
    row.addEventListener("dragstart", start);
    row.addEventListener("dragend", end);
    row.addEventListener("dragover",  over);
}

let draggedRow;
function start(){
    draggedRow = event.target;
    draggedRow.style.border = "3px solid black";
}
function over(){
    let e = event;
    e.preventDefault();
    const droppedInRow = e.target.parentNode;

    let children= Array.from(droppedInRow.parentNode.children);

    if(children.indexOf(droppedInRow) > children.indexOf(draggedRow))
        droppedInRow.after(draggedRow);
    else
        droppedInRow.before(draggedRow);
}


function end()
{
    draggedRow.style.border = "none";
}