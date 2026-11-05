from django.urls import reverse
from rest_framework.decorators import api_view
from rest_framework.response import Response


@api_view(["GET"])
def api_root(request):
    return Response({
        "catalogo": request.build_absolute_uri(
            reverse("catalogo:api-root")
        ),
        "zeladoria": request.build_absolute_uri(
            "/api/zeladoria/"
        ),
        "accounts": request.build_absolute_uri(
            "/api/accounts/"
        ),
    })