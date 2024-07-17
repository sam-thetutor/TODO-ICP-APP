import Buffer "mo:base/Buffer";

actor {

  type TODO = {
    title : Text;
    description : Text;
    status : Bool;
  };

  let todoStore = Buffer.Buffer<TODO>(0);

  ///create
  public func addToDo(_title : Text, _description : Text) : async Text {

    let tempData : TODO = {
      title = _title;
      description = _description;
      status = false;
    };

    todoStore.add(tempData);
    return "task added successfully";
  };
  //read
  public query func getToDo(id : Nat) : async TODO {
    return todoStore.get(id);
  };

  //update
  public func updatToDo(id : Nat, _title : Text, _description : Text) : async Text {

    switch (todoStore.getOpt(id)) {
      case (?data) {

        todoStore.put(id, { data with description = _description; title = _title });
        return "task updated succesffully";
      };
      case (null) {
        return "no task stored at that id";
      };

    };

  };

  //delete

  public func deleteToDo(id : Nat) : async Text {

   ignore todoStore.remove(id);

    return "task deleted successfully";
  };

};
