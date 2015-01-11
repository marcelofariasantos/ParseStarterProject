//
//  ParseStarterProjectViewController.m
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import "ParseStarterProjectViewController.h"
#import "Event.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    Event *RUA = [[Event alloc] init];
    RUA.name = @"Conrado!";
    RUA.location = @"Mi ksa";
    RUA.mes = @"dezembro";
    
    
    //[self getMainEvent];
    //[self getTodosEventos];
    //[self getUsuarios];
    //[self getEventosSexta];
    //[self getEventosCal];
    //[self saveEvent:RUA];
    
    // Ao deletear, atualizar tabela
    //[self getUserConfirmado];
    
    // Editar evento está dando erro. Não consegui deletar (excluir) também.
    //[self editEvent:RUA];
    
    
    
}




- (void) getUserConfirmado {

    PFQuery *query = [PFQuery queryWithClassName:@"Favorite"];
    [query whereKey:@"userID" equalTo:@"hbuiW0anEg"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}


- (void) getMainEvent {
    
    
    // User's location
    //PFGeoPoint *userGeoPoint = userObject[@"location"];
    // Create a query for places
    //PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    // Interested in locations near user.
    //[query whereKey:@"location" nearGeoPoint:userGeoPoint];
    // Limit what could be a lot of points.
    //query.limit = 10;
    // Final list of objects
    //placesObjects = [query findObjects];
    
   
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"start_time" greaterThan: [NSDate date] ];
    [query orderByAscending:@"start_time"];
    //
    // Query com localização do usuário e localização dos eventos
    //
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void) getTodosEventos {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    
    
    //// FILTROS /////
    // Qnt
    query.limit = 10;
    
    // Data - ordem cronlógica
    [query whereKey:@"start_time" greaterThan: [NSDate date] ];
    [query orderByAscending:@"start_time"];
    
    // cidade
    [query whereKey:@"city" equalTo:@"Belo Horizonte"];
    // PAGO OU NAP
    [query whereKey:@"Free" equalTo:[NSNumber numberWithBool:YES]];
    
    /// fim filtros ////
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"mes"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) getUsuarios{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"username"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) getEventosSexta {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"diaSemana" equalTo:@"sexta"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"name"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


    // Query para eventos do dia específico no calendário
- (void) getEventosCal {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"dia" equalTo:@"13"];
    [query whereKey:@"mes" equalTo:@"fevereiro"];
    //Eventos do facebook estão sem ano
    //[query whereKey:@"ano" equalTo:@"2015"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"name"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (void) saveEvent: (Event *) evento{
    PFObject *eventSalve = [self convertByEvent:evento];
    [eventSalve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully");
            // Do something with the found objects

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    // saveEventually irá armazenar a atualização no dispositivo até que uma conexão de rede for restabelecida .
    [eventSalve saveEventually];
    }];
}


- (void) editEvent: (Event *) evento{

    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"ZK97C9FsVm" block:^(PFObject *eventEdit, NSError *error) {
        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully");
            // Do something with the found objects
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        
        eventEdit[@"name"] = @"TESTE";
        
        [eventEdit saveInBackground];
        
        // saveEventually irá armazenar a atualização no dispositivo até que uma conexão de rede for restabelecida .
        [eventEdit saveEventually];
    }];

}



- (PFObject *) convertByEvent: (Event *) evento {
    PFObject *pfEvent = [PFObject objectWithClassName:@"Event"];

    pfEvent[@"name"] = evento.name;
    pfEvent[@"location"] = evento.location;
    pfEvent[@"mes"] = evento.mes;
    
    return pfEvent;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
