Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDACD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 18:51:34 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28194.1781117490553625767
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 11:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LwHjf7sm;
 spf=pass (domain: konsulko.com, ip: 209.85.128.174, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e8833c99fcso80067067b3.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781117489; cv=none;
        d=google.com; s=arc-20240605;
        b=kbUe0We4nyzSZKJjsDj5AjO7YqqOG89l7ErU/Zs+PchhZyejG0eW9z64PWBI5v/95G
         qTdyD/QtcjRCD/1frfVfAUKcrHOklHGaPVHz/n1tXZrE7E37Shs69w2e3PUCkgxRHxgw
         B0ub4uhhmiyjfaH9e2XT0pDcahLRBBrm7C/OviThkU/yLeWkVOEPCXtR/offDYm1v3us
         OuH3z0CQ1OcSyq5sJDPCJJMh1dMf4xZ1IhzPED5p7erIRiMwIuo6dJkzrHimPL1zb+Wm
         iTU8tpMfMCKLpENz/RBE6zUhZIRaKtWTfIACQADw+JyslOlfLBFJOOmZuPjQlM1vpVEW
         klhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PFF4nu5jfn8OrUKTGDJOBAxpqGpCdT/9Ud34m+OYB2w=;
        fh=oelZnrg5dmur//Cq9EZ6v+RhAeHGCj2nFzzrUJxuFwI=;
        b=EZ1bulOnSjIB5S04pySU8k383aP8SRHRnZ9ffW5J5fxxICobdCBCVEp/ePYhVOlkok
         66Xj2Soq4p4qLIvkeOmuKU/aOKMAG2Wp0KY6/bCAUEdqNuAXE7aKPMJO0DbqiXJ+sPei
         2xkVNf/VyObn4/dzSvNI0cWLIpGS+9vTtkMbauKjOQE41JtrvtFre7i/nXwGdRR3Loo4
         ifyAk4qaCqrReQCqPzQ7tVHmZa12+IxIx51431a4Bx8+L9FHaLzgog2I1UM6eZSlTx6p
         W+gCyPUT49gat/jvThrsLBAEVx6vEOvBPMGf3hbH3nbU/N69Bg+4t8+IHDxTDMBMu6Dh
         2N6A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1781117489; x=1781722289; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFF4nu5jfn8OrUKTGDJOBAxpqGpCdT/9Ud34m+OYB2w=;
        b=LwHjf7smm5Z37lIl4TASVx7E9udG7Vw/dntb4cMjEhjDIQ/Kb6cOuiJo1UYZtcERsq
         5i34iRhqIB8gkqeaR158bDJKHnEfzpdIuL5rnufxqbCLypfGF3v54pI0tELyTKky1HaX
         pufsPQzTdGTVL8JkAa9/4JFMiq+LI6O/WIFNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117489; x=1781722289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFF4nu5jfn8OrUKTGDJOBAxpqGpCdT/9Ud34m+OYB2w=;
        b=e4w1txSCeA86bSBlE8fgxfxClJWyCZnRTk31qopqLJZh/m8yM3ZW5cNw/iWsa0Soh7
         4LxtD+E7CT3M5EAs1k4jxZdQ02q/PRFx9UzFfTqhwPiHhkxzmHtG0qwUtTNO9HrNMYKe
         KuOSsAeF8bSiaNi53ESh5ecKK3tGOHQZlpxsD9REThXs/xj+UbjA4Gj8p9mf7K69Sxds
         9nNCeSnSolmJAm60y1w0Gg8M4eNrN/LWuLaAKwSlCnyS+MUhNR/SmbpZnDNwatRg2tyP
         25wugV30nYxJyrtYra4AhXmyo/ckdioUz08draEEYG/ZGh+VqMwzscBBh4RMBJyhPuNt
         npyA==
X-Gm-Message-State: AOJu0YyyOfOe8R3ttD7HHYanoooD1GkI5xhMLNZYgHEKyq3RlWL/18TZ
	5mIwgVGLMESUkeH7xTIoh/uCW4LURhQKg0GjTKAB4HuwXCJJW6pXxDBB+dj6UQFhaj6Jv6N1YHN
	PF1fF80NMsIoy3/QSOUySqsmyapwK+46QFw1vNefz8Q==
X-Gm-Gg: Acq92OHp/66MfyBwCJXCPZQGrmYMqksVZ13e+vkbgOaF8BQcepBHXfmop1aGYSiNMAp
	DN/Ox25DwADV3BxNE5OvdJXxZzWDCVYdNuaE8muIDF/mg8IFEoDzADCcKWSld3Y67XFfr3r3Iq9
	5WYSoRJgIY2+vH85lAocd79VUbADIhaQyPb+wZ5B98QDK9X8tSCu4OHODqZmhnQzqkdlxngSqp2
	q0JOmtal2kLAJ18V7GyjhX+LRKjKLeElsXlmucGyUJxYWn3BhdNu4EASLZDpQ4/GfHfO5rG6kYj
	LzvkKhC+s9KPEgWHZg==
X-Received: by 2002:a05:690c:9683:b0:7b8:f152:7545 with SMTP id
 00721157ae682-7f61711ae77mr5255847b3.9.1781117489484; Wed, 10 Jun 2026
 11:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com> <20260609164032.1415124-5-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260609164032.1415124-5-sandeep.gundlupet-raju@amd.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Wed, 10 Jun 2026 11:51:17 -0700
X-Gm-Features: AVVi8CekyGdzKXRcT1AqyYR343Q0g3MkDYwu0lD39uhVtotk_1TioIq79uVs5kU
Message-ID: <CAOyo-84TdCawcXO3F94VquPT93U=Gah8K8EZeKx7JP0O=WKpwg@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH v3 4/4] README: Document
 --app-dir option usage
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, mark.hatle@kernel.crashing.org, 
	piotr@qbee.io
Content-Type: multipart/alternative; boundary="00000000000043a4d90653eabbad"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 18:51:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4202

--00000000000043a4d90653eabbad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

See comments below.

On Tue, Jun 9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju <
sandeep.gundlupet-raju@amd.com> wrote:

> Update README to reflect the new --app-dir support added to
> dockersetup.py:
>
> - Step 2: Add a note explaining that the default installation base
>   directory inside the containers is /opt (requiring the repo to be
>   cloned at /opt/layerindex), and document the --app-dir option for
>   using a custom  directory (e.g. when the repo is cloned to a
>   non-default path)
> - Database Setup: add note to replace /opt with --app-dir value if used
> - Updating OE data: add same note
> - Security section: add reminder to substitute --app-dir value in the
>   changepassword and axes_reset commands
>
>   AI-Generated: GitHub Copilot (Claude Sonnet 4.6)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  README | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/README b/README
> index 96c2ddd..a292cc5 100644
> --- a/README
> +++ b/README
> @@ -49,6 +49,19 @@ instructions will walk you through the setup.
>
>          ./dockersetup.py -d ~/databasedump.sql -p http://
> <proxyserver>:<port>
>
> +   NOTE: By default, the application is installed inside the containers
> under
> +   /opt (e.g. /opt/layerindex, /opt/migrate.sh). This means you should
> clone
> +   this repository into /opt/layerindex on the host before running the
> script,
> +   or alternatively use the --app-dir option to specify a different base
> +   directory inside the container:
>

This doesn't quite make sense, there is no reason to recommend cloning into
/opt/layerindex on the host, unless you are not running in a container? The
whole point of the dockersetup.py script is to get you running in
containers.


> +
> +        ./dockersetup.py --app-dir /path/to/appdir
> +
> +   For example, if you have cloned the repository to
> +   /scratch2/myuser/layerindex-web, you would run:
> +
> +        ./dockersetup.py --app-dir /scratch2/myuser/layerindex-web
> +
>     NOTE: If you want email sending to work (required for user
> registration and
>     password resets), you should use the -e/--email-host option to specif=
y
> your
>     outgoing email server.
> @@ -99,11 +112,14 @@ Database Setup
>  Once the application is running you'll need to do a bit of further
>  setup within it:
>
> +NOTE: The following commands use /opt as the default base directory. If
> you
> +ran dockersetup.py with --app-dir, replace /opt with the value you
> specified.
> +
>  1. For a fresh database (without importing any database dump) you will
>     need layer data. To import the full set for the master branch from th=
e
>     public instance at layers.openembedded.org you can run the following:
>
> -   docker-compose run --rm layersapp
> /opt/layerindex/layerindex/tools/import_layers.py
> https://layers.openembedded.org
> +   docker-compose -f docker-compose.yml run --rm layersapp
> /opt/layerindex/layerindex/tools/import_layers.py
> https://layers.openembedded.org

Here and throughout, -f docker-compose.yml is redundant (it is the default
for docker-compose).
It might be worth having a note that says "If you are not using the default
docker-compose.yml, you
can pass in another file with -f docker-compose-example.yml". But adding a
redudant extra string
everywhere doesn't really make sense.


>
>
>     Alternatively, you can populate the database manually -
>     you'll need to add at least the openembedded-core layer to the
> @@ -169,19 +185,22 @@ You will likely want to update the OpenEmbedded
> layer information on a regular
>  basis. To do that by fetching and parsing all layer repositories, run th=
e
>  following:
>
> +NOTE: The following commands use /opt as the default base directory. If
> you
> +ran dockersetup.py with --app-dir, replace /opt with the value you
> specified.
> +
>     Incremental update:
>
> -       docker-compose run --rm layersapp
> /opt/layerindex/layerindex/update.py
> +       docker-compose -f docker-compose.yml run --rm layersapp
> /opt/layerindex/layerindex/update.py
>
>     Reload all data (should only be needed if the database structure has
>     changed as part of an upgrade of the application code):
>
> -       docker-compose run --rm layersapp
> /opt/layerindex/layerindex/update.py -r
> +       docker-compose -f docker-compose.yml run --rm layersapp
> /opt/layerindex/layerindex/update.py -r
>
>  Alternatively, you can update the data from an existing layer index
> instance
>  (as per above during setup):
>
> -    docker-compose run --rm layersapp
> /opt/layerindex/layerindex/tools/import_layers.py
> https://layers.openembedded.org
> +    docker-compose -f docker-compose.yml run --rm layersapp
> /opt/layerindex/layerindex/tools/import_layers.py
> https://layers.openembedded.org
>
>
>
> @@ -356,7 +375,9 @@ REGISTRATION_OPEN =3D False
>    reset function ( /accounts/password_reset/ ) or alternatively from the
>    backend you can run the following command:
>
> -  docker-compose exec layersapp /opt/layerindex/manage.py changepassword
> <username>
> +  docker-compose -f docker-compose.yml exec layersapp
> /opt/layerindex/manage.py changepassword <username>
> +
> +  (Replace /opt with your --app-dir value if you used a custom directory=
.)
>
>  * The web-based password reset function will ask the user answers to
>    security questions they selected and answered when they created the
> @@ -387,7 +408,9 @@ REGISTRATION_OPEN =3D False
>      (default 4, resets after an hour). The lockout can be removed
>      immediately using the following command:
>
> -    docker-compose exec layersapp /opt/layerindex/manage.py axes_reset
> +    docker-compose -f docker-compose.yml exec layersapp
> /opt/layerindex/manage.py axes_reset
> +
> +    (Replace /opt with your --app-dir value if you used a custom
> directory.)
>
>      If you wish to disable this, remove or comment out "axes" in
>      INSTALLED_APPS. For more information on configuring axes, see:
> @@ -412,12 +435,12 @@ To back up the database within the docker-based
> setup, you can run the
>  following command (no need to substitute ${MYSQL_ROOT_PASSWORD}, it's
>  already present within the container environment):
>
> -docker-compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root
> --password=3D${MYSQL_ROOT_PASSWORD} --max_allowed_packet=3D512M layersdb'=
 |
> gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
> +docker-compose -f docker-compose.yml exec layersdb /bin/sh -c
> '/usr/bin/mariadb-dump -u root --password=3D${MYSQL_ROOT_PASSWORD}
> --max_allowed_packet=3D512M layersdb' | gzip > backup-`date
> +%Y_%m_%d_%H%M`.sql.gz
>
>  To restore one of these backups you would run the following command (tak=
e
>  care, this will overwrite the data immediately without prompting!):
>
> -zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c
> '/usr/bin/mariadb -u root --password=3D${MYSQL_ROOT_PASSWORD} layersdb'
> +zcat backupfile.sql.gz | docker-compose -f docker-compose.yml exec -T
> layersdb /bin/sh -c '/usr/bin/mariadb -u root
> --password=3D${MYSQL_ROOT_PASSWORD} layersdb'
>
>
>
> --
> 2.43.0
>
>

--00000000000043a4d90653eabbad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>See comments below.</div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun =
9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju &lt;<a href=3D"mailto:san=
deep.gundlupet-raju@amd.com">sandeep.gundlupet-raju@amd.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Update README to=
 reflect the new --app-dir support added to<br>
dockersetup.py:<br>
<br>
- Step 2: Add a note explaining that the default installation base<br>
=C2=A0 directory inside the containers is /opt (requiring the repo to be<br=
>
=C2=A0 cloned at /opt/layerindex), and document the --app-dir option for<br=
>
=C2=A0 using a custom=C2=A0 directory (e.g. when the repo is cloned to a<br=
>
=C2=A0 non-default path)<br>
- Database Setup: add note to replace /opt with --app-dir value if used<br>
- Updating OE data: add same note<br>
- Security section: add reminder to substitute --app-dir value in the<br>
=C2=A0 changepassword and axes_reset commands<br>
<br>
=C2=A0 AI-Generated: GitHub Copilot (Claude Sonnet 4.6)<br>
<br>
Signed-off-by: Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlup=
et-raju@amd.com" target=3D"_blank">sandeep.gundlupet-raju@amd.com</a>&gt;<b=
r>
---<br>
=C2=A0README | 39 +++++++++++++++++++++++++++++++--------<br>
=C2=A01 file changed, 31 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/README b/README<br>
index 96c2ddd..a292cc5 100644<br>
--- a/README<br>
+++ b/README<br>
@@ -49,6 +49,19 @@ instructions will walk you through the setup.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./dockersetup.py -d ~/databasedump.sql -p=
 http://&lt;proxyserver&gt;:&lt;port&gt;<br>
<br>
+=C2=A0 =C2=A0NOTE: By default, the application is installed inside the con=
tainers under<br>
+=C2=A0 =C2=A0/opt (e.g. /opt/layerindex, /opt/migrate.sh). This means you =
should clone<br>
+=C2=A0 =C2=A0this repository into /opt/layerindex on the host before runni=
ng the script,<br>
+=C2=A0 =C2=A0or alternatively use the --app-dir option to specify a differ=
ent base<br>
+=C2=A0 =C2=A0directory inside the container:<br></blockquote><div><br></di=
v><div>This doesn&#39;t quite make sense, there is no reason to recommend c=
loning into</div><div>/opt/layerindex on the host, unless you are not runni=
ng in a container? The</div><div>whole point of the dockersetup.py script i=
s to get you running in containers.<br>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./dockersetup.py --app-dir /path/to/appdir<br>
+<br>
+=C2=A0 =C2=A0For example, if you have cloned the repository to<br>
+=C2=A0 =C2=A0/scratch2/myuser/layerindex-web, you would run:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./dockersetup.py --app-dir /scratch2/myuser/la=
yerindex-web<br>
+<br>
=C2=A0 =C2=A0 NOTE: If you want email sending to work (required for user re=
gistration and<br>
=C2=A0 =C2=A0 password resets), you should use the -e/--email-host option t=
o specify your<br>
=C2=A0 =C2=A0 outgoing email server.<br>
@@ -99,11 +112,14 @@ Database Setup<br>
=C2=A0Once the application is running you&#39;ll need to do a bit of furthe=
r<br>
=C2=A0setup within it:<br>
<br>
+NOTE: The following commands use /opt as the default base directory. If yo=
u<br>
+ran dockersetup.py with --app-dir, replace /opt with the value you specifi=
ed.<br>
+<br>
=C2=A01. For a fresh database (without importing any database dump) you wil=
l<br>
=C2=A0 =C2=A0 need layer data. To import the full set for the master branch=
 from the<br>
=C2=A0 =C2=A0 public instance at <a href=3D"http://layers.openembedded.org"=
 rel=3D"noreferrer" target=3D"_blank">layers.openembedded.org</a> you can r=
un the following:<br>
<br>
-=C2=A0 =C2=A0docker-compose run --rm layersapp /opt/layerindex/layerindex/=
tools/import_layers.py <a href=3D"https://layers.openembedded.org" rel=3D"n=
oreferrer" target=3D"_blank">https://layers.openembedded.org</a><br>
+=C2=A0 =C2=A0docker-compose -f docker-compose.yml run --rm layersapp /opt/=
layerindex/layerindex/tools/import_layers.py <a href=3D"https://layers.open=
embedded.org" rel=3D"noreferrer" target=3D"_blank">https://layers.openembed=
ded.org</a></blockquote><div>Here and throughout, -f docker-compose.yml is =
redundant (it is the default for docker-compose).</div><div>It might be wor=
th having a note that says &quot;If you are not using the default docker-co=
mpose.yml, you</div><div>can pass in another file with -f docker-compose-ex=
ample.yml&quot;. But adding a redudant extra string</div><div>everywhere do=
esn&#39;t really make sense.<br>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
<br>
=C2=A0 =C2=A0 Alternatively, you can populate the database manually -<br>
=C2=A0 =C2=A0 you&#39;ll need to add at least the openembedded-core layer t=
o the<br>
@@ -169,19 +185,22 @@ You will likely want to update the OpenEmbedded layer=
 information on a regular<br>
=C2=A0basis. To do that by fetching and parsing all layer repositories, run=
 the<br>
=C2=A0following:<br>
<br>
+NOTE: The following commands use /opt as the default base directory. If yo=
u<br>
+ran dockersetup.py with --app-dir, replace /opt with the value you specifi=
ed.<br>
+<br>
=C2=A0 =C2=A0 Incremental update:<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0docker-compose run --rm layersapp /opt/layerind=
ex/layerindex/update.py<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0docker-compose -f docker-compose.yml run --rm l=
ayersapp /opt/layerindex/layerindex/update.py<br>
<br>
=C2=A0 =C2=A0 Reload all data (should only be needed if the database struct=
ure has<br>
=C2=A0 =C2=A0 changed as part of an upgrade of the application code):<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0docker-compose run --rm layersapp /opt/layerind=
ex/layerindex/update.py -r<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0docker-compose -f docker-compose.yml run --rm l=
ayersapp /opt/layerindex/layerindex/update.py -r<br>
<br>
=C2=A0Alternatively, you can update the data from an existing layer index i=
nstance<br>
=C2=A0(as per above during setup):<br>
<br>
-=C2=A0 =C2=A0 docker-compose run --rm layersapp /opt/layerindex/layerindex=
/tools/import_layers.py <a href=3D"https://layers.openembedded.org" rel=3D"=
noreferrer" target=3D"_blank">https://layers.openembedded.org</a><br>
+=C2=A0 =C2=A0 docker-compose -f docker-compose.yml run --rm layersapp /opt=
/layerindex/layerindex/tools/import_layers.py <a href=3D"https://layers.ope=
nembedded.org" rel=3D"noreferrer" target=3D"_blank">https://layers.openembe=
dded.org</a><br>
<br>
<br>
<br>
@@ -356,7 +375,9 @@ REGISTRATION_OPEN =3D False<br>
=C2=A0 =C2=A0reset function ( /accounts/password_reset/ ) or alternatively =
from the<br>
=C2=A0 =C2=A0backend you can run the following command:<br>
<br>
-=C2=A0 docker-compose exec layersapp /opt/layerindex/manage.py changepassw=
ord &lt;username&gt;<br>
+=C2=A0 docker-compose -f docker-compose.yml exec layersapp /opt/layerindex=
/manage.py changepassword &lt;username&gt;<br>
+<br>
+=C2=A0 (Replace /opt with your --app-dir value if you used a custom direct=
ory.)<br>
<br>
=C2=A0* The web-based password reset function will ask the user answers to<=
br>
=C2=A0 =C2=A0security questions they selected and answered when they create=
d the<br>
@@ -387,7 +408,9 @@ REGISTRATION_OPEN =3D False<br>
=C2=A0 =C2=A0 =C2=A0(default 4, resets after an hour). The lockout can be r=
emoved<br>
=C2=A0 =C2=A0 =C2=A0immediately using the following command:<br>
<br>
-=C2=A0 =C2=A0 docker-compose exec layersapp /opt/layerindex/manage.py axes=
_reset<br>
+=C2=A0 =C2=A0 docker-compose -f docker-compose.yml exec layersapp /opt/lay=
erindex/manage.py axes_reset<br>
+<br>
+=C2=A0 =C2=A0 (Replace /opt with your --app-dir value if you used a custom=
 directory.)<br>
<br>
=C2=A0 =C2=A0 =C2=A0If you wish to disable this, remove or comment out &quo=
t;axes&quot; in<br>
=C2=A0 =C2=A0 =C2=A0INSTALLED_APPS. For more information on configuring axe=
s, see:<br>
@@ -412,12 +435,12 @@ To back up the database within the docker-based setup=
, you can run the<br>
=C2=A0following command (no need to substitute ${MYSQL_ROOT_PASSWORD}, it&#=
39;s<br>
=C2=A0already present within the container environment):<br>
<br>
-docker-compose exec layersdb /bin/sh -c &#39;/usr/bin/mariadb-dump -u root=
 --password=3D${MYSQL_ROOT_PASSWORD} --max_allowed_packet=3D512M layersdb&#=
39; | gzip &gt; backup-`date +%Y_%m_%d_%H%M`.sql.gz<br>
+docker-compose -f docker-compose.yml exec layersdb /bin/sh -c &#39;/usr/bi=
n/mariadb-dump -u root --password=3D${MYSQL_ROOT_PASSWORD} --max_allowed_pa=
cket=3D512M layersdb&#39; | gzip &gt; backup-`date +%Y_%m_%d_%H%M`.sql.gz<b=
r>
<br>
=C2=A0To restore one of these backups you would run the following command (=
take<br>
=C2=A0care, this will overwrite the data immediately without prompting!):<b=
r>
<br>
-zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c &#39;/=
usr/bin/mariadb -u root --password=3D${MYSQL_ROOT_PASSWORD} layersdb&#39;<b=
r>
+zcat backupfile.sql.gz | docker-compose -f docker-compose.yml exec -T laye=
rsdb /bin/sh -c &#39;/usr/bin/mariadb -u root --password=3D${MYSQL_ROOT_PAS=
SWORD} layersdb&#39;<br>
<br>
<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000043a4d90653eabbad--

