Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFFCD6E57
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 09:54:53 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21325.1780394089845087818
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 02:54:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hUt3QN41;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e16f05fd79so28668617b3.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 02:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780394089; cv=none;
        d=google.com; s=arc-20240605;
        b=gL1OpT7HI+mbwaaeU6kBGOng1aJKrkifWguF5u9ORyMYOaYP8aGvXxhqJ6+aCbIEJ+
         whGEynOnI8ro/8o+IaOIf2MjvuKCQLQepcrvPQ2NODOAelO4PHuem9oSjdqZk4Qdi+9c
         uGKP2UjI1HVx6JjZzUG2RY6Yk5XGKzNZ1O5aXZBo/EhPCb2tjUWNROijDVxmb8xhFYZW
         tyNYzwKiNnc9OsqmvtFTxPtbopTQGQ5foRq1NB//96lXG/KqEp9ad9nFcV42dPGOl0jP
         IDPCHmm8qtLtKRoJazcQyG5mbzHxjvUv3gUB3vlNLf3MR8yGMWS70t4rMDwTH30ByqbN
         By6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JcIcnwwdpCrGoNyKmqdClM1z+1eBRl+DeT/XJ1ciZvM=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=lVFYc+F/jvyu8WrBR0/ixMKsoJf7c0TadN/WPQW9bNiZwXzmmrgNc7MOmKw+Nb2nZ1
         c1TWMiiHhhw9K7btCv9bNnfmUCwD5eLV8RAW/1vGqwNGZlkmhgj+y/j4IrU3ATGPWEO7
         AfzxQliJ2R8Q4xdpup+w5as1aUpY9To0ep8Zt+gTIB680wYvCmVFb2CDJvmfjsjkWedE
         9hg0uzoZIgx+RqGGqiaCvHzHZJZMSOJwMlVKPXSlSnyPOU4HtVC1wslRTvRHaN3XP5YY
         R/ne+0Uzu313yQb4yDKDf0h6g1STF7EJ8XAgvB1Al2k5h4uHrQelar3C7Olfe+mntvXq
         j3fg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780394089; x=1780998889; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcIcnwwdpCrGoNyKmqdClM1z+1eBRl+DeT/XJ1ciZvM=;
        b=hUt3QN41brsdi38rTkqCuHLi0zcxHvf1E/lke+pDkWVeyAuZanDL+e31bB6aTbc+Rj
         EikzvmO4x3b7Xz3QRY5TFweK4x2f7F5hg17U6nQ6QvbB4N6fjHFngO1xB1GSx8QA0+TX
         4pdmehrPG+UHHI5AcKlTTYOIaC5PJNBDwGWPrWsw90y7CIDY0SijGjqkK32x0vZkw6KG
         +w8Ur/nmfeQYupOc9WPjCppZqF7Do65mn+ZfNqm43IZcoc85/7Jx1ccb6imoK7Dezl2C
         /7pO/mO7munAnTbs0W4nQaDRtLAf8X+ZvJdgCq2ODAc4H/qn4RM8vN92uHCMzeAxT/o/
         xtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780394089; x=1780998889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcIcnwwdpCrGoNyKmqdClM1z+1eBRl+DeT/XJ1ciZvM=;
        b=kZ7SJr9pJ+Hw9GYXZ4IY+2l1PqJCUUrRM+ndeIBMKY+tMiDUQUVVGcTyqsNTzthU1i
         FQttRfeKhTWQ7RyJT5Sha63psekC7np7QKbd5G0dBe3CZPN3NdR1ROnbnLh+074etKYb
         6Q+wIdGC5SG+j7Omr8A65Jnlnz02FpQUby3SLzEJnmvi8M0QPOwu24Rci5sVRmL72Use
         ekDekOH0g861hGc1prEk4iowKR57jY0gcitRuhsMVj5gDIYizDNOXNSQKXKyk9sEGsrT
         1cRSEx9R8ETEM6V3bdlxsEUoOioIxlgYqU9yJssX5Qz6l0e3DpN3rem1PcIqoNv2mp7f
         4Fbw==
X-Gm-Message-State: AOJu0YzYLv9exx4lcBT9rFej3KK/5tFYMy9q56OCq858Tm0J1h/ZJ+PP
	wVc5c3scwhUcMn5EzNrD9LF839JWVDaQ7c+9DyoCdBWpB0GAlfDovsYy3pxC/30eMyQW6b9Xuq8
	zQSFdrLDNZN0FrbasTlCGBWy0nbn/DFc=
X-Gm-Gg: Acq92OFCT9E1fRpdxLulg8f5B8qlOOZtTEOuJcvdjHxlfEwX+uwm0sW1IbCaGW9G6xd
	r/lWRjLLqeTmoU4+N1y4CCIT57NRcVl7IvRH7Xzrh5I8ogVuzLs7XK+MUdQY88zEhtImVJzF7V6
	paYCkZaduZs07i+Me7rV99pTXvuDR8gZSFi06EYz64GhpB3C/BO6h5qYYCkDwTSSBN6jkkPf30B
	kNEGV2PPwRanGs6CG6evNitI62A1i/x+YNh6BQ7HwJJnn52izPLvjegSq16MPi6DbxIBLrlNViA
	Cs9akKo06Z4XGEN/Y6KDiuG3z16teVxovvb0GctqWugwpNoAZUZg
X-Received: by 2002:a05:690c:7288:b0:7bf:4a8:3ebb with SMTP id
 00721157ae682-7e060e40a99mr132892857b3.39.1780394088924; Tue, 02 Jun 2026
 02:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260601113410.1896488-1-daniel.turull@ericsson.com>
In-Reply-To: <20260601113410.1896488-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Jun 2026 11:54:37 +0200
X-Gm-Features: AVHnY4LhI909Ttk2DPZweA33jSAFsX8ScV2MsnTDv5acFRvImA_07c4RdXrWcxA
Message-ID: <CANNYZj-whMyFZ2DRT7xZPafjCx_gQs-9rgSNnm_ao43PouxE2w@mail.gmail.com>
Subject: Re: [AUH] [PATCH] upgrade-helper: add state module and --incremental mode
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 09:54:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4109

On Mon, 1 Jun 2026 at 14:04, <daniel.turull@ericsson.com> wrote:
> Without this, every AUH run retries all candidates regardless of previous
> outcomes, wasting time on recipes that consistently fail or were already
> upgraded recently.

Thanks for working on these, much appreciated! Comments below.

> +    def should_skip(self, pn, version):
> +        entry =3D self.data.get(pn, {}).get(version)
> +        if not entry:
> +            return False
> +        age =3D time.time() - entry.get("timestamp", 0)
> +        if entry.get("result") =3D=3D RESULT_SUCCESS:
> +            return age < self.success_max_age
> +        return age < self.cooldown
> +
> +    def _prune(self):
> +        """Remove stale entries older than their respective max-age."""
> +        now =3D time.time()
> +        for pn in list(self.data):
> +            versions =3D self.data[pn]
> +            for ver in list(versions):
> +                entry =3D versions[ver]
> +                age =3D now - entry.get("timestamp", 0)
> +                if entry.get("result") =3D=3D RESULT_SUCCESS:
> +                    if age > self.success_max_age:
> +                        del versions[ver]
> +                else:
> +                    if age > self.cooldown:
> +                        del versions[ver]
> +            if not versions:
> +                del self.data[pn]

I am somewhat confused as to how these functions complement each
other, because they seem to repeat each other's timestamp logic. If
entries that are too old are already pruned at the start, then the
remaining entries will always have their age less than maximum
periods, and it's not necessary to compare times in should_skip(), and
it should simply return True. No?

I also think that any 'decisions' regarding pruning, and skipping
should be at least printed out, so that the log contains information
about why something wasn't attempted, or why it was attempted again,
including information about when it was attempted previously and what
was the result then.

> @@ -520,6 +542,10 @@ class Updater(object):
>                  g['error'] =3D e
>                  failed_pkggroups_ctx.append(g)
>
> +            # Capture upgrade error before commit_changes() which may
> +            # overwrite g['error'] with a git commit failure.
> +            upgrade_err =3D g.get('error') if self.state else None
> +

Such special-casing always makes me a bit uneasy. What is the scenario
where this matters? Did you hit that in testing? If the upgrade itself
succeeded, but the commit failed, then the overall result is 'failed',
and we shouldn't roll it back.

> +            if self.state:
> +                # UpgradeNotNeededError means the recipe is already curr=
ent,
> +                # which is a successful outcome =E2=80=94 no retry neede=
d.
> +                if not upgrade_err or isinstance(upgrade_err, UpgradeNot=
NeededError):
> +                    result =3D RESULT_SUCCESS
> +                else:
> +                    result =3D RESULT_FAILURE

Looking at code, there isn't any place where UpgradeNotNeededError is
actually raised, so you could probably add a patch that removes it
altogether for lack of use?

Alex

