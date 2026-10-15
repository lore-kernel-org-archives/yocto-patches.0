Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A8CC6B38
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 21:54:49 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8970.1792101284742359288
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 14:54:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b83j//cA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so25823955e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792101283; x=1792706083; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x7Pnckq5v2kbDfZx9Ae2XCD9tQLwUbVIRDKOoU6XSeA=;
        b=b83j//cAhgTYvvSD0t2nF+mif7+rWJ+0lM24YpzzR/aY+P86PVQQ22MsskTySZ1Ul7
         fw6MF7NKAcY9Ns63+JbOgHe4NKdbLIZPz8rM3A02ap8nX6Of+A5JOmZvCqMam3MK/Hn+
         BFlCEEVogLjvXi+L4DM3sJzFDm3Pa8vJw+aCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101283; x=1792706083;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7Pnckq5v2kbDfZx9Ae2XCD9tQLwUbVIRDKOoU6XSeA=;
        b=iaLAIs+d1SDIoMRR30COlARsYYxf4DF3GFIyfErxBlhcdR0Bm7ELHoSBrDC8LkpPyv
         DqeWyj+cpZWWBBvphylb+BlimlPdLUjf0vRPwGmGk+nbQ2bMNXgxn8EcEVOtNdSH+fmm
         7TmWYvO9v5d5io4WRQb9MA0er0ZYW+dD79QgFkeNURGD87aMMzjpMjagEa98W/fC22UN
         Y/1ZalOQ65N36ocaDX3PMVmtDi/RKEf8k5MNdJCd62OeFRsHhdlbkLX7cNYLXe6/B6+j
         ySUvNZ5Ues1/kFAQOenxWsbOOmkNe4vRetD0GrrhH2B8dP/LNa7kb+elcoEHs4TKJLRL
         0B7g==
X-Gm-Message-State: AFq9FYLoHHZX30t8C0rHRcUNKcJG0QXAKIlm6Ujc/P0m3i+PgSOe9zPr
	ZqheK841NxIEB/eqI2WcDCBH00taFRFQ0izQphKXgmZmXkvDq8UrPWlewDLPT1xvM3xGleNpV2s
	zgWoY33Y=
X-Gm-Gg: AYBFou15hECnHW62NBaGOPWFcja0L+2FsXOYoZCcB4mDN7SA5YQT+PpwgGZ4xy35W5N
	9WU+B9ht4Zgl5pIzVbX+asmK4jmWfeVbnLEtTEnBcvynvyGufe+RRzJ0ygU9mCF0+YfIyGfkAWS
	W7JBbwgJkn2np05IQjdn1LJ7N/YoyvLZmAmMd2kq1csah0+OeBVLvLtL69Altz/Mo+lPKCZZy0A
	bwo2E7JG5PfANb4CzRLhFS+3KmVgPtp6UoOUIOh0QA+Gi1k8mAA2JeAoKruEg6fBEhEd5LKQnpP
	a4LUfxG4BxWVpSTTykEnpqSCKsRFmukpfbjbf8fQkzLYEv/r6AY6Y5UkfNcd2QnKGyOZGCT2We8
	CY8Qiaxpyv8LWCamiGTHZv0aZpSGlqSMiJREfsh+ZEqOjbgrQPODWXSAeCKHzPZRGuXFfQqJK4j
	vlLec+Mbh6+iB4zurGjOhRQGVAyE+Kop+HmsDriaT10fr98aGbRuFK3sS3LNw4wY1SrMHO+TW0D
	PUKvQk0tL7Y0BPhMeKGXn4kW8UrECEYYlqBn0qA8oSmoTH9s4JDmyYmjmAUvN4=
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr418672185e9.33.1792101282734;
        Thu, 15 Oct 2026 14:54:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dcbd:69cc:7c20:c55f? ([2001:8b0:aba:5f3c:dcbd:69cc:7c20:c55f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c9a68c06sm5125865e9.3.2026.10.15.14.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:54:42 -0700 (PDT)
Message-ID: <8e8f88736ac6608cead460c96fafbc9ded357779.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_client: Fix
 xattr/rename handling with empty paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Thu, 15 Oct 2026 22:54:41 +0100
In-Reply-To: <DM5IZI5V42H3.27O69TM6XIPKC@bootlin.com>
References: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
	 <DM5GBKVJU334.34PL5P3DVVS4R@bootlin.com>
	 <20a05c7e247e12bbf0d2adfb3286f0438ae8ac5f.camel@linuxfoundation.org>
	 <DM5IZI5V42H3.27O69TM6XIPKC@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 21:54:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5032

On Thu, 2026-10-15 at 17:43 +0200, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> So my point is, if pathlen is 0, we have:
>=20
> > 		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash;
>=20
> So full_len is going to be:
> path_extra_1len + 1 + 0 (pathlen) - strip_slash
> So it will be at most:
> path_extra_1len + 1
>=20
> > 		size_t partial_len =3D pathlen - strip_slash;
> > 		if (path_extra_2) {
> > 			full_len +=3D path_extra_2len + 1;
> > 		}
> > 		if (full_len > alloced_len) {
> > 			free(alloced_path);
> > 			alloced_path =3D malloc(full_len);
> > 			alloced_len =3D full_len;
> > 			if (!alloced_path) {
> > 				pseudo_diag("Can't allocate space for paths for a rename operation.=
=C2=A0 Sorry.\n");
> > 				alloced_len =3D 0;
> > 				pseudo_magic();
> > 				return 0;
> > 			}
>=20
> So buffer size is at most `path_extra_1len + 1`
>=20
> > 		}
> > 		if (pathlen) {
> > 			memcpy(alloced_path, path, partial_len - 1);
> > 			alloced_path[partial_len - 1] =3D '\0';
> > 		} else {
> > 			alloced_path[0] =3D '\0';
> > 			partial_len =3D 1;
>=20
> OK, partial_len is 1
>=20
> > 		}
> > 		memcpy(alloced_path + partial_len, path_extra_1, path_extra_1len);
> > 		alloced_path[partial_len + path_extra_1len] =3D '\0';
>=20
> Then here we write at offset `1 + path_extra_1len`.
> So buffer size should be at least `1 + path_extra_1len + 1`
>=20
> > 		if (path_extra_2) {
> > 			memcpy(alloced_path + partial_len + path_extra_1len + 1, path_extra_=
2, path_extra_2len);
> > 		}
> > 		alloced_path[full_len - 1] =3D '\0';
> > 		path =3D alloced_path;
> > 		pathlen =3D full_len;
> > 		pseudo_debug_call(PDBGF_IPC | PDBGF_VERBOSE, pseudo_dump_data, "combi=
ned path buffer", path, pathlen);
>=20
> Hopefully this makes a bit more sense now :)

Yes, I think you're right. I'll add an extra 1 unconditionally to full_len =
to cover all the options...

Thanks,

Richard

