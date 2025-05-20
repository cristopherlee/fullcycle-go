# Etapa 1: Compilação do binário Go com todas as otimizações
FROM golang:1.23 AS builder

WORKDIR /app

COPY main.go .

# Compilação estática sem CGO e com otimização avançada
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o /go/bin/fullcycle main.go

# Etapa 2: Imagem final - scratch (zero dependências)
FROM scratch

WORKDIR /

# Copia apenas o binário compilado
COPY --from=builder /go/bin/fullcycle /fullcycle

# Define o ponto de entrada
ENTRYPOINT ["/fullcycle"]