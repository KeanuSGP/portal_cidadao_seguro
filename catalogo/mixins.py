from uuid import uuid4

from django.db import models
from django.utils.text import slugify


class CodigoAutomaticoModel(models.Model):

    codigo = models.SlugField(
        max_length=100,
        blank=True,
        editable=False,
    )

    class Meta:
        abstract = True

    def save(self, *args, **kwargs):

        if not self.codigo:
            base = slugify(self.nome)[:60].strip("-") or "item"

            self.codigo = f"{base}-{uuid4().hex[:12]}"

        super().save(*args, **kwargs)