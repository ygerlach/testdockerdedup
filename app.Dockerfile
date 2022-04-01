FROM testingbase:latest as builder

WORKDIR /app

RUN printf "%s\n" "deb http://deb.debian.org/debian bullseye main" \
	"deb http://deb.debian.org/debian-security/ bullseye-security main" \
	"deb http://deb.debian.org/debian bullseye-updates main" \
	"deb http://deb.debian.org/debian bullseye-backports main" \
	>/etc/apt/sources.list

RUN apt-get update \
	&& apt-get -y install --no-install-recommends \
	make \
	gcc \
	xxd \
	build-essential \
	&& apt-get -qq -y autoremove --purge \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./ ./

RUN mv libmylib.so app/libmylib.so && make prog



FROM testingbase:latest

COPY --from=builder /app/app/myprog ./

ENV LD_LIBRARY_PATH=/app/

ENTRYPOINT ["/app/myprog"]
CMD []