Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB871FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:20:10 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40670.1777285202714354964
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:20:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XfK8aEUA;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a093c784b0so115104576d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777285202; cv=none;
        d=google.com; s=arc-20240605;
        b=AWFsFdyjy+JTqyBrgHrf+r7s0BtC++JVwJLSkD4Pvc46JXCRwS0vGi9LLf96tHrpb0
         SLsEjTEi0XoYEGHFSgpyDHCHliWVwoc/0xBDH39EVVqNdyLX8GqVr8UIjHX7guXu8tJ/
         22wbVnCxwLsO9eUZ+ebJFu/QG4YqWFUhCwwy4x4RaLhQLAX7fPVKpSay3wdlAoZn3Krg
         rsvshfWXLbST7wEqrt82mpRRr/Jx1zH/JGaNWclIpI9MhEbhCkZWBirULXQbt5EnvYDJ
         z0ml6ysGDTZJYrK6yJLrDblXTabZjxiYn7ZdEaDqB3pRzvgkX9x5RkwwS1RhJ32hIzsi
         EThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E8+ydvxF/qDrhO2HWKQVNwFR4S6k12PLVWTuSnVfTMQ=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=WAlTR1s6L+WlJLhxG/JVXtwsDsRXctckqGaG2p/y6jmedMPI913FOIAJO0qZHDz3+U
         TSv3ULlWXCx55NnSH8WEKTAjoynjUNQ9BYU6xZN8Hh0Bvo25ru9lef/PtPmVZsgqZ8U+
         6ASdVv29JCwEIHJ2fbbjbLo6uYXK0UuzErPfVQyBVSDj6cL4PVkQf+9WldSXYOi3LzXr
         4nQkFbxzhG3DQYE9ahYlHiJhfe4W3UI2EoknGgn71lVBOm0umXOQO1ycSzX//mY82UA2
         hiExf9NWou3gHp7GQzyj87fQtZr5qat5UvKYE4Jfk3wfDGv/CzoywGaGMrJZMdZMAebT
         VG6g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777285202; x=1777890002; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8+ydvxF/qDrhO2HWKQVNwFR4S6k12PLVWTuSnVfTMQ=;
        b=XfK8aEUAkgu1WsYaVPTpWdEn2CZIfAqJizrnFqJWL+6EquHGtj3RAaCUL2qXN69YIF
         OAYSXzCjtT4sLckhFQvgG3NGe9Zzu+LP7j3MyEUapF6B5bDx5InzeshjdDVgPjmCLt+c
         50pczDsxvq9HPe4LrjKpSm2Hmg3pv6xQLWWNx7FDGhker+cdwgCGkiHStiBawrLli8k0
         SMUDgOFN/2rr5eXAQooqxDfzo8zzVLlc17dLp+xUGlLwdcFSCfAFfno/LTkTH43KilRI
         0fjedbcrN+I+NtRArHHnZ4JB53Zp8bm52VBAtAB/erUt/A02IDQxGzJAeZF3bxvY33W0
         miAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285202; x=1777890002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8+ydvxF/qDrhO2HWKQVNwFR4S6k12PLVWTuSnVfTMQ=;
        b=jA/h+M9KTY2aewk7cK1oCIAO2b+ptjCmGf6ngnUuXP94tKcZhjl9C6KUxn2uIzTLJY
         ck2leDjHwGbRCGaKKpWXd85APqo5SIk45Q78hBE5wOjMt3CA4024KcEE1Ro2MuFz4Q5k
         ifUeWCNcG58piLZgiwDQJ9MJsA70Iq8Qv5Kl0KmdUG4lJB7jDShd+Ems6lP3fBFKrdo9
         T82RN9pvNY9XAWKXqYNAxM/kIiGT/ArqFctN3h8HDq3s+MEXvDasB98rOytpQozSBOXu
         o9xPulwhCe7g4TM3pybjU1w5tHlN+Vord6w2AVd86Lr/BmLyZ4MZWyODuP4nv/A2bif0
         /TJw==
X-Gm-Message-State: AOJu0YySapwKemWtGHKp1cArC66upbwGWrv6ntSNaZ3sp6zCEkdymFOG
	4hvGfesxhnPEKBqVmIv7DbEumK3wmswNufmk0jDypIx/Zp/d9MHZ6Kxxq9OzyQzu3DbzwQdUYIa
	M6OoaRic0cUlGTwYzYp28wjaXL2O4dV4=
X-Gm-Gg: AeBDieuYQ65KlI7XofSQWUlNaAznsh8GnGUuJAr9kAh8TGnvjLFtrHUJttYH2bN4FCR
	IkLjxNjCMVkhUNb0GltqcpxO6MR1ZVopiq2Gez1Trh9fP0oKoumThvq7hHv0U/t9VhsP1j+2bHN
	fLhtf/g6D1LuiL1y6jKCFjPX4RFMETq/j6GIVFkKlw4bD1G18LKqGo9lAgmMmDpiasGp7vK7zIo
	7PHZPZHwHNMDDkglx0WV8MJDF1sVYFUS3679Rdd4NC3JckBmzuVwA07CluJddjLgDXqJTWaSpgD
	qKI+UZzorwfW2iIhaytZzX+7mVNyFCvn+lo/sDmLOPIWWHyek6dO
X-Received: by 2002:a05:6214:2a47:b0:8a7:16f8:442a with SMTP id
 6a1803df08f44-8b028139a98mr645284586d6.39.1777285201469; Mon, 27 Apr 2026
 03:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-8-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-8-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:19:49 +0200
X-Gm-Features: AVHnY4IJ4DhbA-k2e8rbbsHb7MnW-XKX6wrxzF4q4s2_-HJGmQkyPuUKeMqJyYw
Message-ID: <CANNYZj_e0Ms7DhyaxUT2Jx_ijkarVGSzuHW+NPpf1Q2ikPCOoQ@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 7/9] upgrade-helper.py: Add prebuild option
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3835

There's already a buildhistory option which does such a pre-build and
size comparison? Perhaps you can extend buildhistory with hooks into
additional external checks?

Alex

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Add --prebuild option to build each recipe at its current version before
> attempting the upgrade. This allows verifying that recipes build before
> applying the upgrade and enables comparing binaries produced before and
> after, for example for build size or ABI compatibility checks.
>
> Recipes that fail the pre-build are skipped and recorded as failures.
>
> Assisted-by: Claude, Anthropic
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  upgrade-helper.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index ffa7449..11a97d2 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -105,6 +105,9 @@ def parse_cmdline():
>      parser.add_argument("--minor", action="store_true", default=False,
>                          help="allow upgrades within the same major version (e.g. 3.5.2 -> 3.6.0, 3.99.0)")
>
> +    parser.add_argument("--prebuild", action="store_true", default=False,
> +                        help="build each recipe at its current version before attempting upgrade")
> +
>      parser.add_argument("-d", "--debug-level", type=int, default=4, choices=range(1, 6),
>                          help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
>      parser.add_argument("-e", "--send-emails", action="store_true", default=False,
> @@ -516,6 +519,21 @@ class Updater(object):
>              attempted_pkggroups += 1
>              pkggroup_name = g["name"]
>              I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total_pkggroups))
> +
> +            # Build current version first to verify it builds and seed ABI reference
> +            if self.args.prebuild and not self.args.skip_compilation:
> +                I(" %s: Pre-building current version ..." % pkggroup_name)
> +                try:
> +                    for machine in self.opts['machines']:
> +                        self.bb.complete(" ".join([p['PN'] for p in g['pkgs']]), machine)
> +                except Exception as e:
> +                    E(" %s: Pre-build FAILED, skipping upgrade" % pkggroup_name)
> +                    if isinstance(e, Error):
> +                        E(e.stdout + e.stderr)
> +                    g['error'] = e if isinstance(e, Error) else Error(message=str(e))
> +                    failed_pkggroups_ctx.append(g)
> +                    continue
> +
>              try:
>                  for pkg_ctx in g['pkgs']:
>                      I(" %s: Upgrading to %s" % (pkg_ctx['PN'], pkg_ctx['NPV']))
> @@ -571,6 +589,8 @@ class Updater(object):
>              tim.run()
>
>          for g in pkggroups_ctx:
> +            if 'workdir' not in g:
> +                continue
>
>              if g in succeeded_pkggroups_ctx:
>                  os.symlink(g['workdir'], os.path.join( \
> --
> 2.34.1
>

