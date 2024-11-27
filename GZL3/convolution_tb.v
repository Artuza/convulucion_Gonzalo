module convolution_tb();

    parameter N = 16;
    parameter LEN1 = 3;
    parameter LEN2 = 50;

    reg signed [LEN1*N-1:0] signal1; // Arreglo empaquetado para signal1
    reg signed [LEN2*N-1:0] signal2; // Arreglo empaquetado para signal2
    wire signed [(LEN1+LEN2-1)*2*N-1:0] conv_result; // Resultado empaquetado

    integer i; // Variable para bucles

    // Instancia del módulo de convolución
    convolution #(N, LEN1, LEN2) uut (
        .signal1(signal1),
        .signal2(signal2),
        .conv_result(conv_result)
    );

    initial begin
        // Inicializar señal fija signal1
        signal1[0*N +: N] = 16'sd819;   // 0.5 en Q15
        signal1[1*N +: N] = -16'sd1966; // -1.2 en Q15
        signal1[2*N +: N] = 16'sd1311;  // 0.8 en Q15

        // Inicializar señal variable signal2 con valores aleatorios
        for (i = 0; i < LEN2; i = i + 1) begin
            signal2[i*N +: N] = $random % (2**N - 1) - (2**(N-1));
        end

        // Agregar un retraso para permitir la propagación
        #10;

        // Imprimir señales y resultados de la convolución
        $display("Señal 1 (signal1):");
        for (i = 0; i < LEN1; i = i + 1) begin
            $display("signal1[%0d] = %d", i, signal1[i*N +: N]);
        end

        $display("\nSeñal 2 (signal2):");
        for (i = 0; i < LEN2; i = i + 1) begin
            $display("signal2[%0d] = %d", i, signal2[i*N +: N]);
        end

        $display("\nResultados de la Convolución (conv_result):");
        for (i = 0; i < LEN1 + LEN2 - 1; i = i + 1) begin
            $display("conv_result[%0d] = %d", i, conv_result[i*2*N +: 2*N]);
        end

        $stop;
    end

endmodule
