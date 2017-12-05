defmodule NotableWeb.NoteControllerTest do
  use NotableWeb.ConnCase

  alias Notable.Notes
  alias Notable.Notes.Note

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:note) do
    {:ok, note} = Notes.create_note(@create_attrs)
    note
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all notes", %{conn: conn} do
      conn = get conn, note_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create note" do
    test "renders note when data is valid", %{conn: conn} do
      conn = post conn, note_path(conn, :create), note: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, note_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, note_path(conn, :create), note: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update note" do
    setup [:create_note]

    test "renders note when data is valid", %{conn: conn, note: %Note{id: id} = note} do
      conn = put conn, note_path(conn, :update, note), note: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, note_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, note: note} do
      conn = put conn, note_path(conn, :update, note), note: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete note" do
    setup [:create_note]

    test "deletes chosen note", %{conn: conn, note: note} do
      conn = delete conn, note_path(conn, :delete, note)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, note_path(conn, :show, note)
      end
    end
  end

  defp create_note(_) do
    note = fixture(:note)
    {:ok, note: note}
  end
end
