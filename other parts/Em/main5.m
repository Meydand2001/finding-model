for i=1:10
    subplot(2,5,i);
    semilogy(1:500,abs(alphainfo{10+i}));
    grid on;
    legend('$|\alpha|$',' modified $|\alpha|$','$||r||$','$||v||$','Interpreter','latex');
end