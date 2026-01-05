Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CEC79F89
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 12:21:21 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62787.1767615676361844812
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 04:21:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T0DE15IB;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed66b5abf7so19532901cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 04:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767615675; x=1768220475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOGuJ69JABiFyNr/gnDgM22oq4a8CGzP97IaAMl5U7A=;
        b=T0DE15IBWHHZ84Os4UsJc4woyiIJjrP+M8wOUpjd2hT6t7OiFMfHVmSt/rl7W4ty24
         TzXvmI7vqbM8bKnpYR3u/djSBuWsyYiKC3EAHGKZ6rwiKBMrfY7FX84dgWu6Pjban4GY
         aB9crnx1FYDv5dAvkX5Tz0Lwfoxs9xBJ+CUbZO+XSCCqZAJMyJoRY4PQncVBLOdg222H
         O1io0inDODhjSUKQa4Tn/OHsXKa77JxqrpN82x7k5uEtNPxLhwyAXNoJauLn37mCP61K
         qT91IljQQfzHTqCW4/RBNXlOVBwRepQTsfTj8ZFgBXKHNH5EADoSFZnbyy94ADLkiB5v
         yNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615675; x=1768220475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOGuJ69JABiFyNr/gnDgM22oq4a8CGzP97IaAMl5U7A=;
        b=r4JEvXdCGKcfmc/9fn4498WugViKS0UwAF9HBZZvzQv/+iGCJ992rZpkfUzakN5Sap
         71fg6/tblEHDowICycOsE+YQKhWfyZ7nwiVBNN7xIRu6AN+FMJNi+c1UJ1itZ6eC7OTR
         lSwdMzmF8+D2rWhij06BoiXlcpU0guwY6SHl+PbeoWUNh3mIqPrRwjfNo0KtBRjB76YK
         9wEBkE8VEWJAxlDBPpWzIlRbfxXSo9sv2wAb+b1FBWgDaQsBjyhW4TqCK5JMI4UFkLe9
         46ZDuXxCTQDIXhy6w/rmhYasY1uwmYbZAsgDsgO55/2+pqyWFwIMSlCuAKqPJxpOXip1
         FM/A==
X-Gm-Message-State: AOJu0Yxrkwr6CQYNwnv1rtM229khHzyy/ne51nofGikRW3iA6yyU5Vh2
	MUm5ZFNvMygSLTljUbKz8nro8QoIzAAs0koULI5R0+4wsraWCw0LF7KZNY/hwTTSTsJH81JI2ms
	cnX2m5mPMWJp44sQpWT4yzVX6VIDbST0EZOUq
X-Gm-Gg: AY/fxX5XrYROZvlv+qe9btcphZZj7eY/DEe44lzxFcb/1nLP1OUcZgTfb4lxjo5vXnY
	UyAdZ6Y62fQ180P5sNxgIPUsCAinlPGVtLg9q31cvpXwxS6bT/Zmt93ZW6D+JyMkdzNQWNjCdhl
	DcASvcMqvW/NvWmoKx9LqIv1fxSzgQzjVKWNRlFApCm55VQleiYi7Oi/Q9x7V93/8a2AN2MIKEr
	97UDqZe2AjefK9mxPO9v2MQuu7JvL53odPNmVxnDESDQWxDh//NxXK4WW4OlguVgzTQQA==
X-Google-Smtp-Source: AGHT+IF+piZbVr1/AnhqT9ZFBYzBuSSWZvc7KGPhDUNsQ0jCZcrUjQOWSX3aWUKNUua5hxlUtQ8naX5u4vSUTB8Q78o=
X-Received: by 2002:a05:622a:40f:b0:4ed:a2dc:9e51 with SMTP id
 d75a77b69052e-4ff46b05e66mr96616091cf.21.1767615675170; Mon, 05 Jan 2026
 04:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20260104004708.2494403-2-t.f.g.geelen@gmail.com> <20260104004708.2494403-9-t.f.g.geelen@gmail.com>
In-Reply-To: <20260104004708.2494403-9-t.f.g.geelen@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 5 Jan 2026 13:21:04 +0100
X-Gm-Features: AQt7F2qlWJ3BrVHM9YKIfHqfan1DHGS76ealS5i2D66kUsiT4fQn1ceYbm88sJ4
Message-ID: <CANNYZj8QazvbiZ1F+E8QF88kbdCeCi3gX9ha=W+3jkgbz1krLg@mail.gmail.com>
Subject: Re: [auh][PATCH 5/5] Record commit failures as group errors in
 Updater class so that commit errors are not treated as SUCCESS but as a FAILURE
To: Tom Geelen <t.f.g.geelen@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 12:21:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2895

On Sun, 4 Jan 2026 at 01:49, Tom Geelen <t.f.g.geelen@gmail.com> wrote:

> What is happening before: commit_changes() throws, run() catches it and r=
emoves the group from succeeded_pkggroups_ctx, but it never sets g['error']=
. The Statistics.update() logic classifies groups purely by g['error'] is N=
one =E2=86=92 =E2=80=9CSucceeded=E2=80=9D. So you end up with =E2=80=9CSucc=
eeded: 1=E2=80=9D even though commit failed.
>
> Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
> ---
>  upgrade-helper.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 165fd42..8457c7b 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -528,6 +528,8 @@ class Updater(object):
>              except Exception as e:
>                  import traceback
>                  E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name=
, traceback.format_exc()))
> +                # Ensure commit failures are recorded as group errors
> +                g['error'] =3D e
>                  if g in succeeded_pkggroups_ctx:
>                      succeeded_pkggroups_ctx.remove(g)
>                      failed_pkggroups_ctx.append(g)

The first four commits are fine and I'll apply and push them, but this
one needs a different fix first.

Specifically, commit_changes() runs even when there's nothing to
commit (e.g. devtool upgrade failed and no changes were produced), and
then it fails. In this situation, the actual error is that devtool
failed, not that there was no code to commit, and this fix would
obscure that devtool error.

Looking at commit_changes, it has this bit:

        except Error as e:
            msg =3D ''

            for line in e.stdout.split("\n"):
                if line.find("nothing to commit") =3D=3D 0:
                    msg =3D "Nothing to commit!"
                    I(" %s: %s" % (pns, msg))

            I(" %s: %s" % (pns, e.stdout))
            raise e

So we either need to suppress the 'raise e' when there's nothing to
commit, or run commit_changes() only if there are actual changes ('git
status --porcelain' can help there).

This has been a long-standing issue with autobuilder AUH, it's full of
traceback clutter because of it, e.g.
https://autobuilder.yoctoproject.org/valkyrie/#/builders/38/builds/46/steps=
/15/logs/stdio
(line 9916 onwards).

Alex

