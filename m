Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B7CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:52:17 +0000 (UTC)
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12680.1790949131333327671
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 06:52:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=N+xmcMM4;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Tt3Enp49;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 63DFAEC0122
	for <yocto-patches@lists.yoctoproject.org>; Fri,  2 Oct 2026 09:52:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790949130;
	 x=1791035530; bh=xL4VipznMxwAESUnoN3d2ix9qzGbDiyP7L/XNDtPrMs=; b=
	N+xmcMM4RXu/1FfRvjHc4YC8mMcRfpVhdy8CWf/YZshUe4xfwTRJSZ9OybdxyacW
	Xj1WBwIxHIxcxV5U8THtNDX3YpHNQtYR6jlmkRw2rP6Dz/TiYZ24Jzcfer3MfPmP
	cbMzogpa5JCtAaVx3xL903LYpgxx0j7eGtntyhwGtLALV2qsZx7pANbRU+L6ybiI
	ZB8TG3U1iZ/T/LUNwXsraOMv/ANRAx8IImIu4V2PPWyuK8jehuFXVJoYsUl/KBig
	ZNxm/QDD0ndCVI+b33Tob2MBDkgc9l/7tXftcFUNlGt7WrWOYIt8DJ/7TFnix2pT
	S1kGzpVSM+HixhYAaMJtKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790949130; x=
	1791035530; bh=xL4VipznMxwAESUnoN3d2ix9qzGbDiyP7L/XNDtPrMs=; b=T
	t3Enp49LI9iXrCYAd6zq+zv93C46Sooo2evM2GL50EcGlOYHC2MO0Tt++WdW65cl
	aZEh0YCUVWbcyoh0pPcpDbJKv/BtUK+O2A/NNHcAGFXxG9IGtUjVkPSzLFDl8n2V
	+ivkFMhnSWWHA13b6Y/jOldbFlnzhxlTITOzi6CEUDGh66lum/SoMxiWoBbV/BpB
	94l6wWUE7oNgsPETWRCfo7xGt8bDwiekj5HWlE6zNPr0aB0iVVQUX1EAG3COIDU0
	WGLhDKH2498kSVMJTUBkNifkH/iMh3Ayiy4+r4jkmM7WMBM1YAw3WtVKsGZ5i5bX
	6YJYyER9D4PXKaS9hvL9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790949130; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4=;
	s=fm3:rsa-sha256:XYgS7DIxokuPeljCXuiN7Lh1vba5aZyjtjL/N8MsIuxKmgp
	YgFchKE/asshedtWe6ecHFZMgRBpN6HIme03lTp8/USogxXwemFWznLv23uhmH/T
	tEvZkmMKM2y2X5yEfCdzIdsGDOjks2UPqKKG+NCg9JGYynvhzB11UXBhjJcHC30g
	O5HrJIQSQcrjBsMb0NkGbPPT331l6aKDfEeCkahokIwLr4j+54JZVfm5x/i2Bnp4
	EX+dA7RPIYVhnXdTi0jE/22msuc337FHJs/8uRuNagc2bZMXmRugD0PwKpJwlXMY
	ihsGgXs8RV4D3bnMaR1hQ3aavLa+pZBYZHhvV0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:m1G2zk8p0C+woy6RY22PW7VmRliZsSvHB/AVZpTSOCE=:o3/M/jXcbRT4S9KO6jo03Tokz4IpPwyhNCzRoGFs8jk=;
X-ME-Sender: <xms:Cbe_akV6Bw690j4lPSnFADc43wvMsuYRBX1-b2jQcCm_KKYjcV8ktA>
    <xme:Cbe_aumsOBeFYqLdTceuxE-C2SkoMd5ihxE0Vw2sH3rMBzeS4FDPPB7gCRs9GaD0F
    YWtvcIo2PRUn_hAt6-AgyPvWb1-4KZ0xjQRdbWolXiJmEU2Eu6SkkI>
X-ME-Received: <xmr:Cbe_amDrj3cQjrOX5zJ0Q3ZtgdwDA_08pjzwHe7KEWay446h18c7ekrwC4wJAOhdbT4>
X-ME-Proxy-Cause: dmFkZTFSYBoj89Wg+VLVnvy55TpP0ksH0vgo8X+zmNZtfwJX7JlA2+Mv4FP8JtRJkI3DcW
    kspTpJtyfJq70nFNFNx73xGiLkV2KpLEOzVEzP/P32HwL0QdJ+yZcdD2+7WeBFCqGpZex9
    4pgMXkS9vj/B11nRZarDxf6b0a391Cpcy4vtsnzBLSCN6b+10itGC91qVK/fCVcDl/EQbT
    MQ2wr8SxFhe/2aqyrO/VjbfzPJ+gHiiCQXIelWFrIU1tzbR9Ai/j8n1fhyzSNlKq5ie1WC
    6Y3+dy+kxZT1//3xCl6ewcjYkNJr1MBrMdkBUW/2NVDok+T3u3QidqSuLrvhirRh+AvMO/
    dVpAEVZ7Yqa9uf80n84vY6yqwD/F/WnG70kpjTWKxXA7CPDR/0JE71qmSlBauraq1SLdqx
    pDjaGKptUK2KIvBL6TjnUNh3e7UMZGsw3IQDnWXEDdgrbvhWnYzUyVgylFBctNbkhdNLzp
    K5PJ18AO1R+vS/7/qJlAYCuZPPvVIAf16bpu+f3mDo3Eu+VEEf4FZ9fk5i4X3OYS+cjXRG
    DvkwdvGHRamlwNbpAVthG90oUg7ezwH+MSWQUBY2F0nlP95NdtNHpzjklwhYamDarUwEHI
    9xtkUBWbKO3Wrn3I5QJHhdECH7yktSnkpuyyuQ3co5tw8yrPjrd3ZfHG50Yw
X-ME-Proxy: <xmx:Cbe_aufAGZoWmnKKr54iVRkHURUqf75xpJAQMo9NyfalbRYVFkIZzw>
    <xmx:Cbe_ahIqAdGm8APllTIQif_jNAiG9wDBCel28Glr8OyHNtaX4MALjQ>
    <xmx:Cbe_ahcBewuWcAZhvBVGmJLgPynPgDchdcHO9l2jN5I2qXQHFL84qw>
    <xmx:Cbe_ao3TIjVs4YW5ybhsSAUCXiGxSKje1xxJ7gdNGThB5shrpUqpBg>
    <xmx:Cre_almcGg-WQTNUBga_hYECamFtMpetTvryLLr2HqW5N9Rv1Gpevl_p>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 09:51:28 -0400 (EDT)
Message-ID: <43b035b778869e3e79dad16c959cddf905c28d53.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v3 2/6] test: Add open_tree test
From: Paul Barker <paul@pbarker.dev>
To: Dmitry Sakhonchik <frezidok1@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
In-Reply-To: <CAP4GjN74fVGqkBpW7h-HLz28+5=PajHz6nCCTiJYmXDF53=8pg@mail.gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
	 <20260907111843.26746-3-frezidok1@gmail.com>
	 <5aaaf1ec9fe53be5da40a6501786ac03888f5d82.camel@pbarker.dev>
	 <CAP4GjN74fVGqkBpW7h-HLz28+5=PajHz6nCCTiJYmXDF53=8pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:16:41 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1.1 
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 13:52:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4982

On Mon, 2026-09-21 at 12:38 +0300, Dmitry Sakhonchik wrote:
> =D0=BF=D0=BD, 21 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12=
:09, Paul Barker <paul@pbarker.dev>:
>=20
> > On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> > > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> > >=20
> > > [YOCTO #16379]
> > >=20
> > > Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH ca=
se.
> > >=20
> > > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> > > ---
> > >  test/test-open_tree.c  | 139 +++++++++++++++++++++++++++++++++++++++=
++
> > >  test/test-open_tree.sh |   5 ++
> > >  2 files changed, 144 insertions(+)
> > >  create mode 100644 test/test-open_tree.c
> > >  create mode 100755 test/test-open_tree.sh
> > >=20
> > > diff --git a/test/test-open_tree.c b/test/test-open_tree.c
> > > new file mode 100644
> > > index 0000000..0fc02f4
> > > --- /dev/null
> > > +++ b/test/test-open_tree.c
> > > @@ -0,0 +1,139 @@
> > > +#define _GNU_SOURCE
> > > +
> > > +#include <errno.h>
> > > +#include <fcntl.h>
> > > +#include <stdio.h>
> > > +#include <unistd.h>
> > > +#include <sys/stat.h>
> > > +#include <sys/mount.h>
> > > +
> > > +#define TEST_DIR "test-open-tree-dir"
> > > +#define TEST_FILE "test-open-tree-file"
> > > +
> > > +static int test_no_flags(void) {
> > > +    int treefd =3D -1;
> > > +    int fd =3D -1;
> > > +    int rc =3D 1;
> > > +
> > > +    treefd =3D open_tree(AT_FDCWD, TEST_DIR, 0);
> > > +    if (treefd =3D=3D -1) {
> > > +        perror("open_tree");
> > > +        goto out;
> > > +    }
> > > +
> > > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > > +    if (fd < 0) {
> > > +        perror("openat");
> > > +        goto out;
> > > +    }
> > > +
> > > +    rc =3D 0;
> > > +out:
> > > +    if (treefd !=3D -1) {
> > > +        close(treefd);
> > > +    }
> > > +    if (fd !=3D -1) {
> > > +        close(fd);
> > > +    }
> > > +    return rc;
> > > +}
> > > +
> > > +static int test_relative_dirfd(void) {
> > > +    int basefd =3D -1;
> > > +    int treefd =3D -1;
> > > +    int fd =3D -1;
> > > +    int rc =3D 1;
> > > +
> > > +    basefd =3D open(".", O_PATH | O_DIRECTORY);
> > > +    if (basefd < 0) {
> > > +        perror("open");
> > > +        goto out;
> > > +    }
> > > +
> > > +    treefd =3D open_tree(basefd, TEST_DIR, 0);
> > > +    if (treefd < 0) {
> > > +        perror("open_tree");
> > > +        goto out;
> > > +    }
> > > +
> > > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > > +    if (fd < 0) {
> > > +        perror("openat");
> > > +        goto out;
> > > +    }
> > > +
> > > +    rc =3D 0;
> > > +out:
> > > +    if (basefd !=3D -1) {
> > > +        close(basefd);
> > > +    }
> > > +    if (treefd !=3D -1) {
> > > +        close(treefd);
> > > +    }
> > > +    if (fd !=3D -1) {
> > > +        close(fd);
> > > +    }
> > > +    return rc;
> > > +}
> > > +
> > > +static int test_at_empty_path(void) {
> > > +    int treefd =3D -1;
> > > +    int dirfd =3D -1;
> > > +    int fd =3D -1;
> > > +    int rc =3D 1;
> > > +
> > > +    dirfd =3D open(TEST_DIR, O_PATH | O_DIRECTORY);
> > > +    if (dirfd < 0) {
> > > +        perror("open");
> > > +        goto out;
> > > +    }
> > > +
> > > +    treefd =3D open_tree(dirfd, "", AT_EMPTY_PATH);
> > > +    if (treefd =3D=3D -1) {
> > > +        perror("open_tree");
> > > +        goto out;
> > > +    }
> > > +
> > > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > > +    if (fd < 0) {
> > > +        perror("openat");
> > > +        goto out;
> > > +    }
> > > +
> > > +    rc =3D 0;
> > > +out:
> > > +    if (dirfd !=3D -1) {
> > > +        close(dirfd);
> > > +    }
> > > +    if (treefd !=3D -1) {
> > > +        close(treefd);
> > > +    }
> > > +    if (fd !=3D -1) {
> > > +        close(fd);
> > > +    }
> > > +    return rc;
> > > +}
> > > +
> > > +static void cleanup(void) {
> > > +    if (unlink(TEST_DIR "/" TEST_FILE) =3D=3D -1 && errno !=3D ENOEN=
T) {
> > > +        perror("unlink");
> > > +    }
> > > +    if (rmdir(TEST_DIR) =3D=3D -1 && errno !=3D ENOENT) {
> > > +        perror("rmdir");
> > > +    }
> > > +}
> > > +
> > > +int main(void) {
> > > +    cleanup();
> > > +
> > > +    if (mkdir(TEST_DIR, 0777) =3D=3D -1) {
> > > +        perror("mkdir");
> > > +        return 1;
> > > +    }
> > > +
> > > +    int rc =3D test_no_flags() || test_at_empty_path() ||
> > test_relative_dirfd();
> >=20
> > This will short-circuit on the first failing test. We should run all
> > test cases and accumulate the pass/fail results.
> >=20
> > > +
> > > +    cleanup();
> >=20
> > Do we need to run cleanup() between test cases? Or at least cleanup
> > TEST_FILE between test cases?
> >=20
>=20
> I don't think so. In every test case we always open TEST_DIR with open_tr=
ee
> and then openat(TEST_FILE) with O_CREAT.
> So I think removing this file is not necessary.

Ok. I'm happy this isn't needed.

Best regards,

--=20
Paul Barker


