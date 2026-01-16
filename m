Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C1C982DB
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 16:30:26 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1172.1768581021754019001
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 Jan 2026 08:30:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ceySk4at;
 spf=pass (domain: gmail.com, ip: 74.125.224.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-644715aad1aso2609049d50.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768581021; x=1769185821; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip7+b6SHWIwsg3BbZ9bj46EeVmoaukzDNyZPB67/f8w=;
        b=ceySk4ata7K8RMf5z/yj638hQKK8N00huoJm+uBGeDVrI8sFUI7Ddb0Civ9wc6B63Q
         gkmJb3Ygv//ay9qTcyUQ4pJEUUIa1qbVn2hKBSQ4CwtIWngyvQAEkaFZkCc+FsiwHl6y
         kBYVr3+LYc5tg0QuRUIAGvtfpzCrKW6ZrmSZnChQtD+W5s+NH2IPQxxXfdtO5mzXIvTX
         cjGGJA6aaxvxfSJ1VWUMtNNVlUDlZ4vgGJFgLEVtnoo5or0JDxnvOgPBr+KXdiHu8V8N
         Xbk9fD2BVfplu7pbILshQ9CdgcwCmAEyTkUqv0YgvzS1tkUYsrjpZhqLVMCCw6+RXQpD
         fUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581021; x=1769185821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ip7+b6SHWIwsg3BbZ9bj46EeVmoaukzDNyZPB67/f8w=;
        b=r1/o9S68u1uHL3jluLpyq2gp6e5GkVr6tJyZVUkFtqZh3bnxZeyR8DnXz3U349v5SE
         Za2Zk5bgWPNv7cPiT6arJ/zuS+nG8Ne07v2u6y4WG9tb/LvJKsidx3WSNhUZDAUpLJKV
         MX9u+6gxxkzCqHMEOqYsdqSz8Kkg7h04dRFUTbxkQzJIq39CQrbfmFbTtkUy79Pr3BG5
         OCRU5ddVSGLONCk/p3Lk9mpAsK5l/6Rn4xJtDm5aoliCww+JLhZAN7L9UGr52w1FiR1Q
         muN+h7m0drNQmcw0SVc6yiPbnPkzYzkwvZZb3pjLR9+idG1VKezv6/J8US0mC6yE7+Q+
         kZdQ==
X-Gm-Message-State: AOJu0YzYrnyo9wDATJByKmGRqr63ElnABVPcsDDFkqe6tVkGTsH2Zb5F
	gtpmHoSx2fRT7RjNfTuo97y1tBwc0Dsg7Nyzy5+RrdAR9TmqNeAC8vwvTP0zRuzXsA497s4/aBh
	7ifWe/D8tMl/g9OAzGzY/atQhi1niwSJRMg==
X-Gm-Gg: AY/fxX7R4N49kQEGIOp/2Qngn4J0yJpLdbqJm+yM9A1QO8RfC4RXFhWyBmaC34YfHMW
	ROU7G70qFlCNDoYXKYk41rJ88W+AMC7mgFM0pJDbz9Tm9BtTZgMwB3FTqRn3jARk61Kl8BrK3CF
	AYelbh1dYEWUvRRbrzbeLkUpM87UFfdPV4SWyoatP/vjvefwDqb62k+0LeA/LcF2gz9h7LtxUUV
	Ix8lugovuGU0IblH5yNbL7A3QJ9KTauZ9RefjG6CyL6cf81cIRFgnPjXuBKU03+U7sVk05ce5JY
	vDGzzKctHIn0R/Wpjegs
X-Received: by 2002:a05:690e:4195:b0:645:53eb:a108 with SMTP id
 956f58d0204a3-6491691b7a7mr2601771d50.12.1768581020826; Fri, 16 Jan 2026
 08:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20260116050512.3751871-1-Qi.Chen@windriver.com>
In-Reply-To: <20260116050512.3751871-1-Qi.Chen@windriver.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 16 Jan 2026 09:30:09 -0700
X-Gm-Features: AZwV_QjwvDO0kr9hW9LfSZCXALDyHA_AzjKTsa3L2BXamEW7_J0b6QzkZNZz_Dk
Message-ID: <CAJdd5GZzFkiDvUFkNCeMxa+L=Mn9YthqOwRJF2JrowjkKawp+w@mail.gmail.com>
Subject: Re: [meta-mingw][PATCH] mingw_sdk_handle_symlink.bbclass: avoid using
 non-posix -d option for read
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 16:30:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3002

On Thu, Jan 15, 2026 at 10:05=E2=80=AFPM <Qi.Chen@windriver.com> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> The '-d' option for read is bash specific extension. We need to
> avoid using it.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  classes/mingw_sdk_handle_symlink.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk=
_handle_symlink.bbclass
> index 2f6dbe6..e158d14 100644
> --- a/classes/mingw_sdk_handle_symlink.bbclass
> +++ b/classes/mingw_sdk_handle_symlink.bbclass
> @@ -3,7 +3,7 @@ WINSDK_NO_SYMLINK ?=3D "0"
>  archive_sdk:prepend:sdkmingw32 () {
>         if [ "${WINSDK_NO_SYMLINK}" =3D "1" ]; then
>                 for parse_type in "file" "directory"; do
> -                       find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 |=
 while IFS=3D read -r -d '' symlink; do
> +                       find "${SDK_OUTPUT}/${SDKPATH}" -type l -print | =
while read -r symlink; do

This would now break on file names with spaces in them; As much as I
would like to say "don't do that", is there some we we can preserve
the behavior of using -print0 to allow that to keep working?

>                                 target=3D$(readlink -f "$symlink" || echo=
 "NOTVALID")
>                                 if [ "$target" =3D "NOTVALID" ]; then
>                                         continue
> --
> 2.43.0
>

