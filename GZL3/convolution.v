module convolution #(parameter N = 16, parameter LEN1 = 3, parameter LEN2 = 50)(
    input signed [LEN1*N-1:0] signal1,   // Arreglo empaquetado para signal1
    input signed [LEN2*N-1:0] signal2,   // Arreglo empaquetado para signal2
    output reg signed [(LEN1+LEN2-1)*2*N-1:0] conv_result // Arreglo empaquetado para resultado
);

    integer i, j;

    // Desempaquetar y almacenar en arreglos temporales
    reg signed [N-1:0] s1 [0:LEN1-1];
    reg signed [N-1:0] s2 [0:LEN2-1];
    reg signed [2*N-1:0] temp_conv [0:(LEN1+LEN2-2)];

    always @(*) begin
        // Desempaquetar las señales de entrada
        for (i = 0; i < LEN1; i = i + 1) begin
            s1[i] = signal1[i*N +: N];
        end
        for (i = 0; i < LEN2; i = i + 1) begin
            s2[i] = signal2[i*N +: N];
        end

        // Inicializar el resultado de la convolución
        for (i = 0; i < LEN1 + LEN2 - 1; i = i + 1) begin
            temp_conv[i] = 0;
        end

        // Realizar la convolución
        for (i = 0; i < LEN1; i = i + 1) begin
            for (j = 0; j < LEN2; j = j + 1) begin
                temp_conv[i + j] = temp_conv[i + j] + s1[i] * s2[j];
            end
        end

        // Empaquetar el resultado
        for (i = 0; i < LEN1 + LEN2 - 1; i = i + 1) begin
            conv_result[i*2*N +: 2*N] = temp_conv[i];
        end
    end

endmodule
