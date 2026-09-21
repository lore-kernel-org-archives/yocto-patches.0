Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F45C982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 09:09:23 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45075.1789981753534481034
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 02:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=NE1TkGX1;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=TYLDO9Fo;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BE647A00E9;
	Mon, 21 Sep 2026 05:09:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 21 Sep 2026 05:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789981752;
	 x=1790068152; bh=GpGnlYVKQfG8YEpwHLbtLNWaVgUXlLL7+DLa/ZvRY1g=; b=
	NE1TkGX1r0yl9wi7nhBgjieGdfwuKmlxSHNPjogqmsoE8/EiENoDCogFt/uO6Opq
	Q4Vfk/SHSfqX2oHCOkuG7V6QgBrdixWbIY2hOD4AMO+0KWCTD7R/83oAzXa48fiW
	3E/8iM/rbyTo6DCe2EQA23f96CRn9ByjAAa6U43wjY+uKxedqEsx5TBwPkk7IomL
	Ur3F9/+M2L7vH1nvYbWJ7Ij9BqRqM6IYx+/eqShZ4H/hptzKzyX1bsWSfJfnd1cr
	UUjwasKJ6Bs4OZVix/eQ6r61jCengS2JlIuIGMLvARMmT7DJeBSo3UeKe2lSlR7+
	NQqlZAXpZJHht7q8xd6Mig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789981752; x=1790068152; bh=G
	pGnlYVKQfG8YEpwHLbtLNWaVgUXlLL7+DLa/ZvRY1g=; b=TYLDO9FoZ9qMhSfi8
	iV4zxyXXpapsMOa6qe5KVDDDy9cq+95aFJrF1lJ61tI2STQHc4MH56F51hUe/tSh
	j3b3rB/K5gvaJO+1iujwfE5l4BJj9HkjscPUd1RoVhmcZbYZAo4FAPHjPn2Pn1uJ
	NWGLXV6cm3Jfs059FrG4yWoSI+3/OPJ0NazqJhqy4by2RZm9j1AKx31T1+voK1AE
	aoU3SETezoHzXkbsuS7tbsbpbH9RXIWrl+M6YEDXwM9FPyAzmv7/ux3pZTTW8VMp
	VkydtpdHL6M09OYdTpxxGqlZ1sYgXnihFDEIyP9F6DoFEd2/H1WTd7PZqi06cZEf
	SMlMQ==
X-ME-Sender: <xms:OPSwapjJNolodiNisDYkg3rZDpe9SlcV8tAXSgZx9kbTjlosmbiINw>
    <xme:OPSwakAFJiYxBbiDs8XplKupLy0Y-7Gn2GdBZfmH9Pib8ynGxAffedys4Z396MDDW
    h_k0DSl65ieJKc00jgqjRod_bzH2cDV1pja8dxT02TMRiXwr6wQHnJc>
X-ME-Received: <xmr:OPSwamuyMPK5Q3x8xAFbECTjGKchU24LWu__kptXTVrg0mzJCf7kwGtQBwr3pF50TS69>
X-ME-Proxy-Cause: dmFkZTGfCphX+c8v7fhURS06sAHZ44NrIPb/EJBHFCemQAsmZclHH1nw40vrN2uYHwJW79
    SPY75WA4PtU90545OziUuJbiiPfBCpY1z/E6TfwzpRplhVNELaHlfjZl2Uv9F4LhiFaKO5
    z5Z9QzXfaHSWW+s2dFbXvfCYv84Jdn3TKuQNiBzvi4ZZ/B1fsfXilcmzRzyFW8QO3XQ26t
    bGaLvemei6+2VK1vEBOYkfAZYdscsw1LjgsDYxC26XoEU8dRfBZnP3HqkgqIMTzzGYTleV
    h2PLdEFVdLe7adBOyQWxwKnMFjYcJzR3CT2qqRxVgH+j5bwv3JFv9tb8jw2ajbBOpMfmUC
    pYRP0wJH1s6R1lRyQirx2RFozdbGHjkvpT1pdb+ghBNYfWOcrrqF0AugObQCxY7/HXkUP+
    tphbr9o/VEn1b2cB+BzvwG0xVV1ewoZ/4TlJzdYxfP0r2PJzXfuajglLwh6+guXWnk24MS
    cXcpzAI6QzP+pDsghU9TJPalrzl8aiG74WQTQb8Gbpx9JkX9OeOuNwWRCbFRCZPquPUlZh
    qFe6YPtxX90avMRvSOChAMlJg4rqTz4zxLPvd4Zmsfr5SOpJt1ppjdjMqL9fBPxJr8B94X
    KmqCaIn2+gJ2P/Ukkpbo98HySt1S+loI0w84LGZPC4W8Ur1TbiW2bLD2bDEA
X-ME-Proxy: <xmx:OPSwapZihkvizEP0c3s0A-8mnjU5DZ3_V3_qVnVMZF5XHI0vipPwHg>
    <xmx:OPSwapU72cTDdXO6xOeYlBpMx3CGeokWqP5CBbSnUo-StGV2bxHW2Q>
    <xmx:OPSwat4n-ryC8lI8vLuYs-ru8zswndBmZ6SsEW5uuopAVjb7p7p_BA>
    <xmx:OPSwakggkVZKU03Z58SQYwHKIR-VCBAbSOTQozIRfsHfQwXis1R2tw>
    <xmx:OPSwan92HJ3bbb6NFy-2GsVT9xuJ2aOv7Wyx8-R3ZaY7NafqUxxv5Pi2>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 05:09:11 -0400 (EDT)
Message-ID: <5aaaf1ec9fe53be5da40a6501786ac03888f5d82.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v3 2/6] test: Add open_tree test
From: Paul Barker <paul@pbarker.dev>
To: frezidok1@gmail.com, yocto-patches@lists.yoctoproject.org
Date: Mon, 21 Sep 2026 10:09:10 +0100
In-Reply-To: <20260907111843.26746-3-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
	 <20260907111843.26746-3-frezidok1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 09:09:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4918

On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
>=20
> [YOCTO #16379]
>=20
> Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH case.
>=20
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> ---
>  test/test-open_tree.c  | 139 +++++++++++++++++++++++++++++++++++++++++
>  test/test-open_tree.sh |   5 ++
>  2 files changed, 144 insertions(+)
>  create mode 100644 test/test-open_tree.c
>  create mode 100755 test/test-open_tree.sh
>=20
> diff --git a/test/test-open_tree.c b/test/test-open_tree.c
> new file mode 100644
> index 0000000..0fc02f4
> --- /dev/null
> +++ b/test/test-open_tree.c
> @@ -0,0 +1,139 @@
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +
> +#define TEST_DIR "test-open-tree-dir"
> +#define TEST_FILE "test-open-tree-file"
> +
> +static int test_no_flags(void) {
> +    int treefd =3D -1;
> +    int fd =3D -1;
> +    int rc =3D 1;
> +
> +    treefd =3D open_tree(AT_FDCWD, TEST_DIR, 0);
> +    if (treefd =3D=3D -1) {
> +        perror("open_tree");
> +        goto out;
> +    }
> +
> +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> +    if (fd < 0) {
> +        perror("openat");
> +        goto out;
> +    }
> +
> +    rc =3D 0;
> +out:
> +    if (treefd !=3D -1) {
> +        close(treefd);
> +    }
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }
> +    return rc;
> +}
> +
> +static int test_relative_dirfd(void) {
> +    int basefd =3D -1;
> +    int treefd =3D -1;
> +    int fd =3D -1;
> +    int rc =3D 1;
> +
> +    basefd =3D open(".", O_PATH | O_DIRECTORY);
> +    if (basefd < 0) {
> +        perror("open");
> +        goto out;
> +    }
> +
> +    treefd =3D open_tree(basefd, TEST_DIR, 0);
> +    if (treefd < 0) {
> +        perror("open_tree");
> +        goto out;
> +    }
> +
> +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> +    if (fd < 0) {
> +        perror("openat");
> +        goto out;
> +    }
> +
> +    rc =3D 0;
> +out:
> +    if (basefd !=3D -1) {
> +        close(basefd);
> +    }
> +    if (treefd !=3D -1) {
> +        close(treefd);
> +    }
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }
> +    return rc;
> +}
> +
> +static int test_at_empty_path(void) {
> +    int treefd =3D -1;
> +    int dirfd =3D -1;
> +    int fd =3D -1;
> +    int rc =3D 1;
> +
> +    dirfd =3D open(TEST_DIR, O_PATH | O_DIRECTORY);
> +    if (dirfd < 0) {
> +        perror("open");
> +        goto out;
> +    }
> +
> +    treefd =3D open_tree(dirfd, "", AT_EMPTY_PATH);
> +    if (treefd =3D=3D -1) {
> +        perror("open_tree");
> +        goto out;
> +    }
> +
> +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> +    if (fd < 0) {
> +        perror("openat");
> +        goto out;
> +    }
> +
> +    rc =3D 0;
> +out:
> +    if (dirfd !=3D -1) {
> +        close(dirfd);
> +    }
> +    if (treefd !=3D -1) {
> +        close(treefd);
> +    }
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }
> +    return rc;
> +}
> +
> +static void cleanup(void) {
> +    if (unlink(TEST_DIR "/" TEST_FILE) =3D=3D -1 && errno !=3D ENOENT) {
> +        perror("unlink");
> +    }
> +    if (rmdir(TEST_DIR) =3D=3D -1 && errno !=3D ENOENT) {
> +        perror("rmdir");
> +    }
> +}
> +
> +int main(void) {
> +    cleanup();
> +
> +    if (mkdir(TEST_DIR, 0777) =3D=3D -1) {
> +        perror("mkdir");
> +        return 1;
> +    }
> +
> +    int rc =3D test_no_flags() || test_at_empty_path() || test_relative_=
dirfd();

This will short-circuit on the first failing test. We should run all
test cases and accumulate the pass/fail results.

> +
> +    cleanup();

Do we need to run cleanup() between test cases? Or at least cleanup
TEST_FILE between test cases?

> +
> +    return rc;
> +}
> diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh
> new file mode 100755
> index 0000000..1654a0b
> --- /dev/null
> +++ b/test/test-open_tree.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +./test/test-open_tree
> +
> +PSEUDO_IGNORE_PATHS=3D/ ./test/test-open_tree
> \ No newline at end of file

This runs test-open_tree twice but the script exit code only depends on
the second invocation. We should or these two results together.

Nitpick: Missing newline at end of file.

Best regards,

--=20
Paul Barker


