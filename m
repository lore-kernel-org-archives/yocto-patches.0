Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1443.1794857992424374506
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 11:39:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BtDI5H4P;
 spf=pass (domain: konsulko.com, ip: 209.85.216.50, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so278382a91.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794857991; x=1795462791; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CuO8pyiT3mrI1V7EPywclF15lzVkVzxAzIWzzuypzgE=;
        b=BtDI5H4PuxacQLfgZ5oV9yBB7kkzR6LT6vlFjW3UOJZNB15u6fhyhDP4hE+ZnUCQ4a
         KFOIxD8q5u5O8cqCnhCFK4PaILSl4MCcSV2B1RQfoto+7lIJ6nfz4jZySxEQ9SDQxPHk
         wqpK3XGfSQOORDlGj5nUgY0rrOMigJpggYdqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794857991; x=1795462791;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CuO8pyiT3mrI1V7EPywclF15lzVkVzxAzIWzzuypzgE=;
        b=VD0pjInD02MCG5sbja++5xa5ORk6NbqUTO4jt5eG1HCEwxAJo02h34dBZ9rmW8UxCS
         gjOL1xIf2VSvzXP/Ps0saP9lllimM/5s5+RJqmQqkPOSbfsiUWY/rDUWmL16TVhUp1F7
         TOnbZfCzN8V4X3SCtHluCVjJPiA0/fuXRygZqnr0UaJdap1SYv5VjNME3XQrKf/dGJKC
         aBuSsbUdzO4bZESNH2CJSNiBlssX93sENpTExg2behyZnX+oIwCx1qMEmk6W6PyND2/z
         s1jJ5ClMSOHYeSTaKaE198G1BWrsh/NKOctBxWbANZsSrjSRHTODeXIuyfJIIa3HiOdW
         m9ug==
X-Forwarded-Encrypted: i=1; AL+hErFP7ETA/ytEhtJUwRHoXGN/ea8JH+xQFw/m4bH9MBaH101Va0DHaZp2Zg8I5WMgyJ7UD6lJ1KYyNVhX7TsU@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z8D27d8/FNy+kp2Vz0aUu1K8mDLn+JZUcTEbKswRCJXoLO63yM3
	OcCeaDfRP3hvyGSWjJzUZbIz9R627qi3V1bN0SdjdL35GNvcMmNt7J0U0sRMk0rGZFw=
X-Gm-Gg: AZFdTZcWHj5cnfdMEW2ZxGajjnPa4SIToqI0HTLrUAmV1uCtF7FXtTjInfEIBvW3ikL
	PgAy3qJeeicgF/M6QCRSZLstRq0JcxU4ZZP9Lbnf8OUKePIcUgQfn4aPYe1xhputzgIiR4VjVdh
	n5DsOEmiSWwA5bKmJDGqImauR86QQRw2BiGibrKlAreDm3SFc0Od/KdhX6IfA3ltaorAmNBXOqc
	V1PzK3cpHdfBQcMNGNkqYWBjVRgaotxuokbQLZaLtFZ5eercR5nSl1La0QVg1i/ZyCCqohwtKrN
	NK18sVgZlyAIoBCVaLPYNWXMr3nf2wcfnMWn1VDRttddsXgHcwLcecpa/Q30n1thBNq9jxPff9B
	I+Ip1goqFkKhCcwna2QyJ2sC3NOAPVkbdDf9xRgKT4KkFvSIw07oN8FWwoKsoatidI51PEnN8pm
	dW82S4P3cYmkvZTavaxj80SLzXhx0CWWX7VkugOUoVnaKtR35JZfvNhUI1oEu1S/PJUJDr9eczo
	+UYsd/DwHwZHdah9b1M7upw0CivgvRbSAK47OoCR/GLihSdVOoMJfvPs8vXpA4NoG1pEdS1w5/m
	tK8dDR2znjs64G1TipRgQoxujqDCVcEnDj4MBcXlBJnP2pp2iWkjyrmcDk00S6kDq/wkQX6W3Ss
	M3BbAc4BybpFFgp+l0BmOB+RJwSY=
X-Received: by 2002:a17:90b:4d0b:b0:3ac:7556:8eed with SMTP id 98e67ed59e1d1-3b1b0a46811mr10660094a91.44.1794857991405;
        Mon, 16 Nov 2026 11:39:51 -0800 (PST)
Return-Path: <tim.orling@konsulko.com>
Received: from localhost ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abb786f7sm602275a91.1.2026.11.16.11.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 11:39:51 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 11:39:50 -0800
Message-Id: <DMWW21TXTMA0.U1J8251C8C9R@konsulko.com>
Cc: "Tim Orling" <tim.orling@konsulko.com>
Subject: Re: [layerindex-web][RFC PATCH v2 0/2] uWSGI, and a docker-compose
 setup with nginx-proxy
From: "Tim Orling" <tim.orling@konsulko.com>
To: "Tim Orling" <ticotimo@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.22.0
References: <20261115191734.23604-1-tim.orling@konsulko.com>
In-Reply-To: <20261115191734.23604-1-tim.orling@konsulko.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 19:39:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5419

On Sun Nov 15, 2026 at 11:17 AM PST, Tim Orling wrote:
> This is an RFC: I run the layer index test instance I use for these
> patches this way, and would like to know if this is useful upstream,
> and in particular whether the production site would use it.

After some discussion with halstead and some additional research, I am
dropping this series and moving to 'gunicorn' on my test bench(es).

Key takeaways:

* uWSGI is maintenance only since 2022 [1][2]:

  "Note The project is in maintenance mode (only bugfixes and updates for
   new languages apis). Do not expect quick answers on github issues
   and/or pull requests (sorry for that) A big thanks to all of the users
   and contributors since 2009."

* 'gunicorn' is recommended over 'granian' (and some other providers) for
   most users [2]. The article says to keep gunicorn with sync workers
   for a Django app like ours. Bigger gains come from the application:
   caching, query optimisation and removing N+1 queries "typically yield
   10=C3=97 the improvement of switching application servers".

[1] https://uwsgi-docs.readthedocs.io/en/latest/
[2] https://www.deployhq.com/blog/python-application-servers-wsgi-vs-asgi-g=
uide

>
> 1: Serves the application with uWSGI instead of gunicorn. uWSGI speaks
>    HTTP, so the existing nginx configurations are unchanged. It also
>    serves the static files, now collected into the image at build time.
> 2: Adds docker-compose.nginx-proxy.yml, with nginx-proxy and
>    acme-companion in place of the layersweb (nginx) and layerscertbot
>    containers: the certificate is obtained and renewed automatically,
>    with no hand-edited nginx configuration. The existing compose files
>    are unchanged.
>
> Patch 1 can be taken on its own; patch 2 needs it for the static
> files.
>
> This series is based on "docker-compose: run layersapp with an init
> process", sent separately, which isn't an RFC.
>
> Changes in v2:
> - 2: layersapp runs with "init: true", as in the other compose files
>   after the patch above, and the compose file test covers
>   docker-compose.nginx-proxy.yml too.
>
> Tested: the test suite passes in the image; the test instance has run
> uWSGI behind nginx-proxy, with Let's Encrypt, since October.
>
> Open questions:
> - Should uWSGI replace gunicorn, or be an option?
> - dockersetup.py does not know about the nginx-proxy setup; should it?
> - The test instance also waits for the database and runs migrate and
>   collectstatic when the container starts, instead of in
>   dockersetup.py. I left that out; is it wanted?
>
> Tim Orling (2):
>   Dockerfile: serve the application with uWSGI
>   docker-compose.nginx-proxy.yml: add a production setup using
>     nginx-proxy
>
>  .env.prod.proxy                |  7 +++
>  Dockerfile                     | 15 ++++--
>  README.md                      | 12 +++++
>  docker-compose.nginx-proxy.yml | 93 ++++++++++++++++++++++++++++++++++
>  tests/test_dockersetup.py      |  3 +-
>  5 files changed, 124 insertions(+), 6 deletions(-)
>  create mode 100644 .env.prod.proxy
>  create mode 100644 docker-compose.nginx-proxy.yml
>
>
> base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
> prerequisite-patch-id: 4ad6ed99d0c42ce111a25d4731d953218337e7cc


