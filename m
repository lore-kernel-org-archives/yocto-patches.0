Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598FCD8CAD
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 17:18:47 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1431.1763054324504307716
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 09:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X5SNsBSd;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-594516d941cso1170053e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054323; x=1763659123; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3bSpBMC+hozsbS+DnSqqr9LK4G6dn2BUHpEzw4NoX8=;
        b=X5SNsBSdUKkOSTikfoJBWIDGSheEFg+zlrVIEmIJTodPfd73uOJLN4Q9/fhuFdhu1E
         oJe+S3Qxnlexw/x76HmGh3rj+o//tqxIbVGUbg4zRwCzvlHPOlV6jfnSjWm9NXOCJGfO
         dK817kmd1vlU9bKqkF43j7uDhfumadRLJ0HtLp266CF08NgpWoF1BHEfzdRyqDnArkGU
         N2DoHIxuG585YcdG1A5Y0tCpV8EpNo6VViYbO6qgV1AcgF1ySIP1gpl/i4awRfitI+M6
         u/WG/hGi6yKNbKMP0/56Hlwt4bkfR+OLGouwTNoVFqKaxHZdZIhXUnNP2CR+n7DQPLnv
         7nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054323; x=1763659123;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3bSpBMC+hozsbS+DnSqqr9LK4G6dn2BUHpEzw4NoX8=;
        b=mYPxPMrYsXougGn+tGRNOBwSIuU9L+WcVsrPXxbxAe8Ip0EvHh62qDHysW2HSeIEs/
         HQwTE5KgjjvU2ijgMZOduJ3w3WHQ7uT/lK5NbXn+TBHFEoiRbuiTuUxZBYVMOVJ1d+d+
         VLxxDqoerHI9Lqcewl/Prf0M7ttYjV5ZmF82v+HmUOTzngDYyQzObQA5qttnSlvn/bF9
         w8IkHSQlZu8pUNNKdmR49Uk1sdf6Jp5BZOLBqlDC/dY4pdidHaURuUGLBTlOdy4gXeg+
         poYgP2yT56rdpzUzBRwqkuJtW2h5eXeGvNfnPIPpkBUVqbK0elhSzKj/wgqk4vYHOl0f
         c8/A==
X-Gm-Message-State: AOJu0YwVfxsWDhuMAMmMZDR+Qcz5F7vSs7xnnoCS1iCzJ2FNUsGpFGTr
	afSUQAiWP7BUoCnl6xbBDg8cRhVgQR2E7W2FFpGh1C+5ufJm/mwNeqxcMyDjFIiH5nnvdCteou8
	v5N4KJU0CJc8f9OHwgNWGSm1KOaf7jxvs/kpz
X-Gm-Gg: ASbGnctrcq/tcnX9Wug1Uvl562oU8t7S27IVlg6zDKNxxvZ3LRRuUMDNgJQldrSYOMH
	y+yzfB1biPGdmjBRbOpDwiXJK1Cuczk1ipY/+O0Ra9fH+M8qBl32GQaHjprCj/SGQ/Z1DJt1CjI
	Y0zWMG2FhTux13RJf6ImHMsBpMKgzLxbQMSCVbKRiCMM0XLbCSwRglSCv1eMjjfzRXx1F/uHM9+
	s0vmxtLYmldx8l+Diw6oUI3QRVdsuFxuFe3jdpgDdjPDvqmB9SyR2tUTd63nJQ8wcgGWv1eB1i8
	m1c8C7az
X-Google-Smtp-Source: AGHT+IGQgImKnHw/g2uIhzezpN+ywKIGJApV1rXRP/ORNIvGs1JSn42tU9JQfP/EcWMsdjFVGNf+wBxt7vlLipuOznM=
X-Received: by 2002:a05:6512:3c86:b0:592:f3ef:19ad with SMTP id
 2adb3069b0e04-595841e6205mr79374e87.34.1763054322130; Thu, 13 Nov 2025
 09:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20250913173840.3216545-1-skandigraun@gmail.com>
In-Reply-To: <20250913173840.3216545-1-skandigraun@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 13 Nov 2025 18:18:29 +0100
X-Gm-Features: AWmQ_bki5fM1v6r5IRlIiingmmHZGv8ALH0tBV1KOoZ67WccM0N8EJAfhPCzo-8
Message-ID: <CA+chaQeaQqkjO1v+qoo308ZqH17Fk9VLiahPC3dBj_TknckhZQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow-lite: package headers
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 17:18:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2542

Why should tensorflow-lite provide header files from flatbuffers,
cannot it use system headers from flatbuffers recipe? This breaks a
build for recipes which depend on both tensorflow-lite and flatbuffers
because of conflicts in RSS as in:
ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file
/usr/include/flatbuffers/array.h is installed by both tensorflow-lite
and flatbuffers, aborting

I can send a patch to remove them (I have it locally).

On Sat, Sep 13, 2025 at 7:38=E2=80=AFPM Gyorgy Sarvari via
lists.yoctoproject.org <skandigraun=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> The headers are not packages with tensorflow-lite, making it not easy to
> compile any applications using them.
>
> This patch copies the headers from the source and output folder to
> the includedir.
>
> The patch was derived from the content of a pre-compiled tflite package[1=
],
> and from compilation error messages that were returned by rpicam-apps
> recipe (which uses this recipe as an optional dependency)
>
> [1]: https://github.com/prepkg/tensorflow-lite-raspberrypi/releases/tag/2=
.20.0
>
> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
> ---
>  .../tensorflow/tensorflow-lite_2.19.0.bb      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb b/rec=
ipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
> index 14a538a..786507e 100644
> --- a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
> @@ -114,6 +114,29 @@ do_install() {
>          ${D}${datadir}/label_image
>
>
> +    # install the headers also
> +    cd ${S}
> +    for header in `find ./tensorflow/lite -type f -name *.h`; do
> +        install -D -m 0644 $header ${D}${includedir}/$header
> +    done
> +
> +    for header in `find ./tensorflow/compiler/mlir -type f -name *.h`; d=
o
> +        install -D -m 0644 $header ${D}${includedir}/$header
> +    done
> +
> +    for header in `find ./tensorflow/core/public -type f -name *.h`; do
> +        install -D -m 0644 $header ${D}${includedir}/$header
> +    done
> +    cd -
> +
> +    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
> +    for header in `find ./flatbuffers -type f`; do
> +        install -D -m 0644 $header ${D}${includedir}/$header
> +    done
> +    cd -
> +
> +    # header installation done
> +
>      #echo "Installing pip package"
>      install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
>      ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v=
 \
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2186): https://lists.yoctoproject.org/g/yocto-patches=
/message/2186
> Mute This Topic: https://lists.yoctoproject.org/mt/115226423/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

