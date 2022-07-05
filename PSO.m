clear
[x y]=meshgrid(-10:0.05:10);
z=funea(x,y);
surf(x,y,z);
pause
close

%Tłumienie 
alfa = 0.8;  
c1 = 1.23; 
c2 = 1.23; 
n_count=20;

number_of_iterations = 100;
w=10*rand(n_count,2)-7;
v=10*rand(n_count,2)-7;

best_values = []; 
best_position_in_local = w;
best_position_in_global = [];
best_iteration = 1;

fit = funea(w(:,1),w(:,2)); 
[minim, iter] = min(fit);

best_value_global = minim; 
best_value = minim; 
best_position_in_global(1) = w(iter,1);
best_position_in_global(2) = w(iter,2); 
best_value_local = fit;

for iteration = 1:number_of_iterations        
    for k=1:n_count
        r1 = rand;
        r2 = rand;
        v(k,1) = v(k,1) * alfa + c1*r1*(best_position_in_local(k,1)-w(k,1))+ c2*r2*(best_position_in_global(1) - w(k,1)); 
        v(k,2) = v(k,2) * alfa + c1*r1*(best_position_in_local(k,2)-w(k,2))+ c2*r2*(best_position_in_global(2) - w(k,2)); 

        w(k,1) = w(k,1) + v(k,1); 
        w(k,2) = w(k,2) + v(k,2);
    end

    fit = funea(w(:,1),w(:,2));
    [minim, iter] = min(fit);  
    
    if (minim < best_value_global) 
       best_value_global = minim;
       best_position_in_global(1) = w(iter,1);
       best_position_in_global(2) = w(iter,2);
    end
    
    if (best_value > best_value_global) 
        best_value = best_value_global;
        best_iteration = iteration;
    end
    
    for k = 1:n_count
        if(best_value_local(k) > fit(k)) 
            best_value_local(k) = fit(k);
            best_position_in_local(k,1) = w(k,1);
            best_position_in_local(k,2) = w(k,2);
        end
    end

    best_values(iteration) = best_value_global; 
    [x y]=meshgrid(-10:0.05:10);
    z=funea(x,y);
    contour(x,y,z,10);
    hold on;
    plot(w(:,1),w(:,2),'ko');
    if mod(iteration, 5) == 0 || iteration == 1
        %saveas(gcf, strcat('pso_iteration_', num2str(iteration), '.png'));
    end
    
    hold off
    pause(0.1);
end